RSpec.describe MyController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it { should have_http_status(200) }
  end
end
