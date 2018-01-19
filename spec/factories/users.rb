FactoryBot.define do
  factory :user do
    sequence(:account_id) { |n| n }
    room_id                  { Faker::Number.number(8) }
    access_token             { Faker::Internet.password }
    refresh_token            { Faker::Internet.password }
    access_token_expires_at  { 30.minutes.from_now }
    refresh_token_expires_at { 14.days.from_now }
  end
end
