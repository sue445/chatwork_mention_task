RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers

  config.before(:suite) do
    Rails.application.routes.default_url_options[:host] = "example.com"
    Rails.application.routes.default_url_options[:protocol] = "https"
  end
end
