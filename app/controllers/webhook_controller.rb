class WebhookController < ApplicationController
  protect_from_forgery only: []

  before_action :verify_signature!

  # rubocop:disable all
  def skelton
    # TODO: skelton

    Rails.logger.info("params=#{params}") rescue nil
    Rails.logger.info("User-Agent=#{request.headers["User-Agent"]}") rescue nil
    Rails.logger.info("X-ChatWorkWebhookSignature=#{request.headers["X-ChatWorkWebhookSignature"]}") rescue nil
    Rails.logger.info("request.body.string=#{request.body.string}") rescue nil
    Rails.logger.info("request.env=#{request.env["rack.input"].read}") rescue nil

    render plain: "OK", status: 200
  end
  # rubocop:enable all

  def account
    message = WebhookController.format_message(params: params, account_type: @user.account_type)

    ChatWork::Task.create(room_id: @user.room_id, body: message, to_ids: @user.account_id)

    render plain: "OK", status: 200
  end

  # @params params [Hash]
  # @params account_type [String] `chatwork_com`, `kddi_chatwork`
  # @return [String]
  def self.format_message(params:, account_type:)
    url_prefix =
      case account_type
      when "chatwork_com"
        "https://www.chatwork.com"
      when "kddi_chatwork"
        "https://kcw.kddi.ne.jp"
      end
    message_url = "#{url_prefix}/#!rid#{params[:room_id]}-#{params[:message_id]}"

    <<~MSG
      [qt][qtmeta aid=#{params[:from_account_id]} time=#{params[:send_time]}]#{params[:body]}[/qt]
      #{message_url}
    MSG
  end

  private

    def verify_signature!
      @user = User.find_by!(account_id: params[:account_id])

      verify_chatwork_webhook_signature!(@user.webhook_token)
    end
end
