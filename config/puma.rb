# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

plugin :heroku

rails_env = ENV.fetch("RAILS_ENV") { "development" }

if rails_env == "development" && File.exist?("#{__dir__}/server.key")
  server_key = "#{__dir__}/server.key"
  server_crt = "#{__dir__}/server.crt"

  ssl_bind "0.0.0.0", "9292", {
    key:         server_key,
    cert:        server_crt,
    verify_mode: "none",
  }
end
