module User::ApiModule
  extend ActiveSupport::Concern

  def rooms
    all_rooms = with_retryable do
      api_client.get_rooms
    end

    all_rooms.select {|room| ["my", "group"].include?(room.type) && ["admin", "member"].include?(room.role) }.sort_by(&:name)
  end

  def room_name
    room = with_retryable do
      api_client.find_room(room_id: room_id)
    end

    return I18n.t("app.my_chat") if room.type == "my"

    room.name
  end

  def create_task(room_id:, body:, to_ids:, limit_at: nil)
    with_retryable do
      api_client.create_task(room_id: room_id, body: body, to_ids: to_ids, limit: limit_at&.to_i)
    end
  end

  def create_my_task(body, limit_at: nil)
    create_task(room_id: room_id, body: body, to_ids: account_id, limit_at: limit_at)
  end

  def with_retryable
    yield
  rescue ChatWork::AuthenticateError => error
    retry_count ||= 0
    retry_count += 1

    if retry_count == 1 && error.error == "invalid_token"
      refresh_access_token
      retry
    end

    raise
  rescue ChatWork::APIError => error
    retry_count ||= 0
    retry_count += 1

    if retry_count == 1 && error.message == "Invalid API Token"
      refresh_access_token
      retry
    end

    raise
  end

  private

    def api_client
      ChatWork::Client.new(access_token: access_token)
    end

    def oauth_client
      ChatWork::OAuthClient.new(client_id: ENV["CHATWORK_CLIENT_ID"], client_secret: ENV["CHATWORK_CLIENT_SECRET"])
    end

    def refresh_access_token
      tokens = oauth_client.refresh_access_token(refresh_token)
      self.access_token = tokens[:access_token]
      self.refresh_token = tokens[:refresh_token]
      self.access_token_expires_at = tokens[:expires_in].to_i.seconds.from_now
      save!
    rescue ChatWork::AuthenticateError => error
      if error.error == "invalid_grant" && error.error_description.match?(/Invalid refresh token/i)
        raise User::RefreshTokenExpiredError
      end

      raise
    end
end
