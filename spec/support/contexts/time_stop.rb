RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end

RSpec.shared_context :time_stop, :time_stop do
  around do |example|
    travel_to(Time.current) do
      example.run
    end
  end
end
