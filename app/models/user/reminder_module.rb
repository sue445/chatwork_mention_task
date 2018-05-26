module User::ReminderModule
  extend ActiveSupport::Concern

  included do
    scope :remind_target, -> do
      where(refresh_token_reminded_at: nil).
        where("refresh_token_expires_at < ?", User::REFRESH_TOKEN_EXPIRES_REMIND.from_now)
    end

    include Rails.application.routes.url_helpers
  end

  class_methods do
    def remind_refresh_token_will_expire
      remind_target.each do |user|
        Rollbar.scope!(person: { id: user.id, username: user.account_id })
        user.create_remind_task
      end
    end
  end

  def create_remind_task
    create_my_task(remind_message, limit_at: refresh_token_expires_at)

    self.refresh_token_reminded_at = Time.current
    save!

    Rails.logger.info "[User#create_remind_task] Notified remind to account_id=#{account_id}"
  end

  # @return [String]
  def remind_message
    Time.use_zone(time_zone) do
      I18n.with_locale(locale) do
        title = I18n.t("activerecord.user.remind_task.title")
        message = I18n.t(
          "activerecord.user.remind_task.message",
          expires_at:  I18n.l(refresh_token_expires_at),
          sign_in_url: sign_in_auth_index_url(host: Global.app.host),
        )

        "[info][title](F)#{title}(F)[/title]#{message}[/info]"
      end
    end
  end
end
