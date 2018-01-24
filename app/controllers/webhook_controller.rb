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

    render plain: "OK", status: 200
  end

  private

    def verify_signature!
      @user = User.find_by!(account_id: params[:account_id])

      verify_chatwork_webhook_signature!(@user.webhook_token)
    end
end
