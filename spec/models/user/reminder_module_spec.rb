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

  describe ".remind_refresh_token_will_expire" do
    subject { User.remind_refresh_token_will_expire }

    before do
      @user1 = create(:user, refresh_token_expires_at: 14.days.from_now)
      @user2 = create(:user, refresh_token_expires_at: refresh_token_expires_at)
      @user3 = create(:user, refresh_token_expires_at: refresh_token_expires_at, refresh_token_reminded_at: 10.minutes.ago)

      allow_any_instance_of(User).to receive(:api_client) { api_client } # rubocop:disable RSpec/AnyInstance
      allow(api_client).to receive(:create_task)
    end

    let(:refresh_token_expires_at) { 1.hour.from_now }
    let(:api_client) { ChatWork::Client.new(api_key: "xxxx") }

    it "called create_remind_task" do
      subject

      expect(api_client).to have_received(:create_task).with(hash_including(limit: refresh_token_expires_at.to_i)).once
    end
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

      expect(user).to have_received(:create_my_task).with(kind_of(String), limit_at: refresh_token_expires_at)
    end

    it { expect { subject }.to change { user.refresh_token_reminded_at }.to(Time.current) }
  end

  describe "#remind_message" do
    subject { user.remind_message }

    let(:user) { create(:user, locale: locale, time_zone: time_zone, refresh_token_expires_at: refresh_token_expires_at) }
    let(:refresh_token_expires_at)      { "2018-02-01 12:34:56".in_time_zone }
    let(:refresh_token_expires_at_i18n) { "Thu, 01 Feb 2018 12:34:56 +0000" }

    context "with en" do
      let(:locale)    { "en" }
      let(:time_zone) { "UTC" }

      let(:message) do
        <<~MSG.strip
          [info][title](F)from ChatworkMentionTask(F)[/title]Your refresh token is due to expire around #{refresh_token_expires_at_i18n}.
          Please sign in again so far.

          #{Global.app.host}/auth/sign_in[/info]
        MSG
      end

      it { should eq message }
    end

    context "with ja" do
      let(:locale)    { "ja" }
      let(:time_zone) { "Tokyo" }

      let(:message) do
        <<~MSG.strip
          [info][title](F)from ChatworkMentionTask(F)[/title]あなたのリフレッシュトークンは2018/02/01 21:34:56頃に切れます。
          それまでにもう一度ログインしてください。

          #{Global.app.host}/auth/sign_in[/info]
        MSG
      end

      it { should eq message }
    end
  end
end
