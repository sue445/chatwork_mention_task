class WebhookController < ApplicationController
  protect_from_forgery only: []

  before_action :set_user
  before_action :verify_signature!

  def account
    raise ActionController::BadRequest, "webhook_event_type is not mention_to_me" unless params[:webhook_event_type] == "mention_to_me"

    message = WebhookController.format_message(webhook_event: params[:webhook_event], account_type: @user.account_type)

    @user.create_my_task(message)

    Rails.logger.info "task is created"
    render plain: "OK", status: :ok
  rescue User::RefreshTokenExpiredError => e
    Rollbar.error(e)
    Rails.logger.warn "refresh_token is expired"
    render plain: "refresh_token is expired", status: :unauthorized
  end

  # @params webhook_event [Hash]
  # @params account_type [String] `chatwork_com`, `kddi_chatwork`
  # @return [String]
  def self.format_message(webhook_event:, account_type:)
    url_prefix =
      case account_type
      when "chatwork_com"
        "https://www.chatwork.com"
      when "kddi_chatwork"
        "https://kcw.kddi.ne.jp"
      end
    message_url = "#{url_prefix}/#!rid#{webhook_event[:room_id]}-#{webhook_event[:message_id]}"

    <<~MSG
      [qt][qtmeta aid=#{webhook_event[:from_account_id]} time=#{webhook_event[:send_time]}]#{webhook_event[:body]}[/qt]
      #{message_url}
    MSG
  end

  private

    def set_user
      @user = User.find_by!(account_id: params[:account_id])
    end

    def verify_signature!
      return unless Global.app.verify_signature?

      verify_chatwork_webhook_signature!(@user.webhook_token)
    end

    # used for rollbar person tracking
    #
    # @see https://rollbar.com/docs/notifier/rollbar-gem/
    #
    # @return [User]
    def current_user
      @user
    end
end
