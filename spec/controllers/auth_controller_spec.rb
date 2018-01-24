RSpec.describe AuthController, type: :controller do
  describe "GET #callback", :time_stop do
    subject { get :callback }

    before do
      allow(User).to receive(:register) { user }
    end

    let(:user) { create(:user) }

    it { should redirect_to me_path }
  end
end
