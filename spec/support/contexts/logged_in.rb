RSpec.shared_context :logged_in, :logged_in do
  before do
    allow(controller).to receive(:current_user) { current_user }
  end

  let(:current_user) { create(:user) }
end

RSpec.configure do |config|
  config.include_context :logged_in, :logged_in
end
