desc "notification to user who refresh token will expire"
task :remind => :environment do
  User.remind_refresh_token_will_expire
end
