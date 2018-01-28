module User::ReminderModule
  extend ActiveSupport::Concern

  included do
    scope :remind_target, -> do
      where(refresh_token_reminded_at: nil).
        where("refresh_token_expires_at < ?", User::REFRESH_TOKEN_EXPIRES_REMIND.from_now)
    end
  end

  class_methods do
    def remind_refresh_token_will_expire
      remind_target.each do |user| # rubocop:disable Style/SymbolProc
        user.create_remind_task
      end
    end
  end

  def create_remind_task
    body = <<~MSG
      [info][title]from ChatworkMentionTask[/title]Your refresh token is due to expire around #{refresh_token_expires_at}.
      Please sign in again so far.

      #{Global.app.root_url}[/info]
    MSG

    create_my_task(body, limit_at: refresh_token_expires_at)

    self.refresh_token_reminded_at = Time.current
    save!

    Rails.logger.info "[User#create_remind_task] Notified remind to account_id=#{account_id}"
  end
end
