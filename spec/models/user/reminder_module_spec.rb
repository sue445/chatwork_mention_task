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

  describe "#create_remind_task", :time_stop do
    subject { user.create_remind_task }

    let(:user) { create(:user, refresh_token_expires_at: refresh_token_expires_at) }
    let(:refresh_token_expires_at) { "2018-02-01 12:34:56".in_time_zone }

    before do
      allow(user).to receive(:create_my_task)
    end

    it "called create_my_task with limit_at" do
      subject

      body = <<~MSG
        [info][title]from ChatworkMentionTask[/title]Your refresh token is due to expire around #{refresh_token_expires_at}.
        Please sign in again so far.

        #{root_url}[/info]
      MSG
      expect(user).to have_received(:create_my_task).with(body, limit_at: refresh_token_expires_at)
    end

    it { expect { subject }.to change { user.refresh_token_reminded_at }.to(Time.current) }
  end
end
