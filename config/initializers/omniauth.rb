Rails.application.config.middleware.use OmniAuth::Builder do
  provider :chatwork, ENV["CHATWORK_CLIENT_ID"], ENV["CHATWORK_CLIENT_SECRET"], scope: ["users.profile.me:read", "rooms.tasks:write", "rooms.info:read", "offline_access"]
end

# c.f. https://stackoverflow.com/questions/10737200/how-to-rescue-omniauthstrategiesoauth2callbackerror
OmniAuth.config.on_failure = proc do |env|
  AuthController.action(:omniauth_failure).call(env)
end
