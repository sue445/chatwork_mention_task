RSpec.describe AuthController, type: :controller do
  describe "GET #callback" do
    subject { get :callback, params: params }

    let(:params) do
      {
        provider: "chatwork",
      }
    end

    it { should have_http_status(302) }
  end
end
