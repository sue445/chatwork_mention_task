RSpec.shared_context :controller_spec_helper, type: :controller do
  render_views
end

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include_context :controller_spec_helper, type: :controller
end
