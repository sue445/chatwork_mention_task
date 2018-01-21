RSpec::Matchers.define :match_unixtime do |expected|
  match do |actual|
    actual.to_i == expected.to_i
  end

  failure_message do |actual|
    "expected #{expected}(unixtime #{expected.to_i}), but actual #{actual}(unixtime #{actual.to_i})"
  end
end
