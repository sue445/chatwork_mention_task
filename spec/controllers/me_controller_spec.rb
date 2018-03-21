RSpec.describe MeController, :logged_in, type: :controller do
  describe "GET #show" do
    subject { get :show }

    before do
      allow(current_user).to receive(:room_name) { "" }
    end

    it { should have_http_status(:ok) }
  end

  describe "GET #edit" do
    subject { get :edit }

    before do
      allow(current_user).to receive(:rooms) { [] }
    end

    it { should have_http_status(:ok) }
  end

  describe "PUT #update" do
    subject { put :update, params: params }

    let(:params) do
      {
        user: {
          room_id:       room_id,
          webhook_token: webhook_token,
          account_type:  account_type,
          locale:        locale,
          time_zone:     time_zone,
        },
      }
    end

    let(:room_id)       { 1234 }
    let(:webhook_token) { "token" }
    let(:account_type)  { "kddi_chatwork" }
    let(:locale)        { "ja" }
    let(:time_zone)     { "Tokyo" }

    it { should redirect_to me_path }

    it { expect { subject }.to change { current_user.room_id }.to(room_id) }
    it { expect { subject }.to change { current_user.webhook_token }.to(webhook_token) }
    it { expect { subject }.to change { current_user.account_type }.to(account_type) }
    it { expect { subject }.to change { current_user.locale }.to(locale) }
    it { expect { subject }.to change { current_user.time_zone }.to(time_zone) }
  end
end
