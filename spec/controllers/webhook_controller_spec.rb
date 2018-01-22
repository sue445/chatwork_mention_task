RSpec.describe WebhookController, type: :controller do
  xdescribe "POST #mention" do
    subject { post :mention }

    it { should have_http_status 200 }
  end
end
