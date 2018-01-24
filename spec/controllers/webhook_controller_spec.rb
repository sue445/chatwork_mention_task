RSpec.describe WebhookController, type: :controller do
  describe "POST #account" do
    subject { post :account, params: params }

    before do
      allow(controller).to receive(:verify_chatwork_webhook_signature!).with(user.webhook_token)
      allow(ChatWork::Task).to receive(:create)
    end

    let(:user) { create(:user) }

    let(:params) do
      {
        account_id:      user.account_id,
        from_account_id: 1_234_567_890,
        to_account_id:   1_484_814,
        room_id:         567_890_123,
        message_id:      "789012345",
        body:            "[To:1484814]Hello",
        send_time:       1_498_028_125,
        update_time:     0,
      }
    end

    let(:message) do
      <<~MSG
        [qt][qtmeta aid=1234567890 time=1498028125][To:1484814]Hello[/qt]
        https://www.chatwork.com/#!rid567890123-789012345
      MSG
    end

    it { should have_http_status 200 }

    it "called ChatWork::Task.create" do
      subject

      expect(ChatWork::Task).to have_received(:create).with(hash_including(room_id: user.room_id, body: message, to_ids: user.account_id))
    end
  end

  describe ".format_message" do
    subject { WebhookController.format_message(params: params, account_type: account_type) }

    let(:params) do
      {
        from_account_id: 1_234_567_890,
        to_account_id:   1_484_814,
        room_id:         567_890_123,
        message_id:      "789012345",
        body:            "[To:1484814]Hello",
        send_time:       1_498_028_125,
        update_time:     0,
      }
    end

    let(:message) do
      <<~MSG
        [qt][qtmeta aid=1234567890 time=1498028125][To:1484814]Hello[/qt]
        https://www.chatwork.com/#!rid567890123-789012345
      MSG
    end

    let(:account_type) { "chatwork_com" }

    it { should eq message }
  end
end
