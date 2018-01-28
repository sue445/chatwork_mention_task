RSpec.describe User::ReminderModule, type: :model do
  describe ".remind_target", :time_stop do
    subject { User.remind_target }

    before do
      @user1 = create(:user, refresh_token_expires_at: 14.days.from_now)
      @user2 = create(:user, refresh_token_expires_at: 1.hour.from_now)
      @user3 = create(:user, refresh_token_expires_at: 1.hour.from_now, refresh_token_reminded_at: 10.minutes.ago)
    end

    it { should eq [@user2] }
  end
end
