RSpec.describe User::ApiModule, type: :model do
  describe "#with_retryable", :time_stop do
    subject do
      user.with_retryable do
        call_api
      end
    end

    let(:user) { create(:user, access_token_expires_at: 1.day.ago) }
    let(:access_token) { "new_access_token" }
    let(:tokens) do
      {
        access_token:  "new_access_token",
        token_type:    "Bearer",
        expires_in:    "1800",
        refresh_token: "refresh_token",
        scope:         "users.all:read rooms.all:read_write contacts.all:read_write",
      }
    end
    let(:oauth_client) { ChatWork::OAuthClient.new(client_id: "xxxx", client_secret: "xxxx") }

    before do
      @count = 0

      allow(user).to receive(:oauth_client) { oauth_client }
      allow(oauth_client).to receive(:refresh_access_token) { tokens }
    end

    def call_api
      @count += 1

      if @count == 1 # rubocop:disable Style/GuardClause
        raise ChatWork::AuthenticateError.new(
          'Bearer error="invalid_token", error_description="The access token expired"',
          401,
          ["Invalid API Token"],
          "invalid_token",
          "The access token expired",
        )
      end
    end

    it { expect { subject }.to change { user.access_token }.to(access_token) }
    it { expect { subject }.to change { user.access_token_expires_at }.to(30.minutes.from_now) }

    it "call ChatWork::Token.refresh_access_token once" do
      subject

      expect(oauth_client).to have_received(:refresh_access_token).once
    end
  end
end
