module User::ReminderModule
  extend ActiveSupport::Concern

  included do
    scope :remind_target, -> do
      where(refresh_token_reminded_at: nil).
        where("refresh_token_expires_at < ?", User::REFRESH_TOKEN_EXPIRES_REMIND.from_now)
    end
  end
end
