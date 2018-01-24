RSpec.describe WebhookController, type: :controller do
  describe "POST #account" do
    subject { post :account }

    before do
      allow(controller).to receive(:verify_chatwork_webhook_signature!).with()
    end

    let(:user) { create(:user) }

    it { should have_http_status 200 }
  end
end
