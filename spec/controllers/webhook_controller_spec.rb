RSpec.describe WebhookController, type: :controller do
  describe "POST #account" do
    subject { post :account }

    before do
      allow(controller).to receive(:verify_chatwork_webhook_signature!).with()
    end

    let(:user) { create(:user) }

    it { should have_http_status 200 }
  end

  describe ".format_message" do
    subject { WebhookController.format_message(params) }

    let(:params) do
      {
        from_account_id: 1234567890,
        to_account_id:   1484814,
        room_id:         567890123,
        message_id:      "789012345",
        body:            "[To:1484814]Hello",
        send_time:       1498028125,
        update_time:     0,
      }
    end

    let(:message) do
      <<~MSG
        [qt][qtmeta aid=1234567890 time=1498028125][To:1484814]Hello[/qt]
      MSG
    end

    it { should eq message }
  end
end
