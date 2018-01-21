RSpec.describe MyController, :logged_in, type: :controller do
  describe "GET #index" do
    subject { get :index }

    before do
      allow(current_user).to receive(:room_name) { "" }
    end

    it { should have_http_status(200) }
  end

  describe "GET #edit" do
    subject { get :edit }

    before do
      allow(current_user).to receive(:rooms) { [] }
    end

    it { should have_http_status(200) }
  end

  describe "GET #update" do
    subject { put :update, params: { room_id: room_id } }

    let(:room_id) { 1234 }

    it { should redirect_to my_index_path }

    it { expect { subject }.to change { current_user.room_id }.to(room_id) }
  end
end
