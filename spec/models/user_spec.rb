RSpec.describe User, type: :model do
  describe ".register", :time_stop do
    subject { User.register(auth_hash) }

    let(:auth_hash) do
      {
        provider: "chatwork",
        uid: 1_111_111,
        info: {
          name: "sue445",
          email: "sue445@example.com",
          description: "I am cure engineer!",
          image: "https://appdata.chatwork.com/avatar/ico_default_blue.png",
          urls: {
            profile: "http://github.com/sue445",
          },
        },
        credentials: {
          token: "access_token",
          refresh_token: "refresh_token",
          expires_at: 1_510_504_991,
          expires: true,
        },
        extra: {
          raw_info: {
            account_id: 1_111_111,
            room_id: 2_222_222,
            name: "sue445",
            chatwork_id: "",
            organization_id: 1_111_111,
            organization_name: "",
            department: "",
            title: "",
            url: "http://github.com/sue445",
            introduction: "I am cure engineer!",
            mail: "",
            tel_organization: "",
            tel_extension: "",
            tel_mobile: "",
            skype: "",
            facebook: "",
            twitter: "",
            avatar_image_url: "https://appdata.chatwork.com/avatar/ico_default_blue.png",
            login_mail: "sue445@example.com",
          },
        },
      }
    end

    context "when user is not registered" do
      it { expect { subject }.to change { User.count }.by(1) }

      its(:account_id)               { should eq 1_111_111 }
      its(:room_id)                  { should eq 2_222_222 }
      its(:name)                     { should eq "sue445" }
      its(:avatar_image_url)         { should eq "https://appdata.chatwork.com/avatar/ico_default_blue.png" }
      its(:access_token)             { should eq "access_token" }
      its(:refresh_token)            { should eq "refresh_token" }
      its(:access_token_expires_at)  { should match_unixtime(Time.zone.at(1_510_504_991)) }
      its(:refresh_token_expires_at) { should match_unixtime(User::REFRESH_TOKEN_EXPIRES_IN.from_now) }
    end

    context "when user is registered" do
      before do
        create(:user, account_id: 1_111_111, refresh_token: refresh_token, refresh_token_expires_at: 1.day.ago, room_id: room_id)
      end

      let(:room_id) { 2_222_222 }

      context "when refresh token is not updated" do
        let(:refresh_token) { "refresh_token" }

        it { expect { subject }.to change { User.count }.by(0) }

        its(:account_id)               { should eq 1_111_111 }
        its(:room_id)                  { should eq 2_222_222 }
        its(:name)                     { should eq "sue445" }
        its(:avatar_image_url)         { should eq "https://appdata.chatwork.com/avatar/ico_default_blue.png" }
        its(:access_token)             { should eq "access_token" }
        its(:refresh_token)            { should eq "refresh_token" }
        its(:access_token_expires_at)  { should match_unixtime(Time.zone.at(1_510_504_991)) }
        its(:refresh_token_expires_at) { should match_unixtime(1.day.ago) }
      end

      context "when refresh token is updated" do
        let(:refresh_token) { "old_refresh_token" }

        it { expect { subject }.to change { User.count }.by(0) }

        its(:account_id)               { should eq 1_111_111 }
        its(:room_id)                  { should eq 2_222_222 }
        its(:name)                     { should eq "sue445" }
        its(:avatar_image_url)         { should eq "https://appdata.chatwork.com/avatar/ico_default_blue.png" }
        its(:access_token)             { should eq "access_token" }
        its(:refresh_token)            { should eq "refresh_token" }
        its(:access_token_expires_at)  { should match_unixtime(Time.zone.at(1_510_504_991)) }
        its(:refresh_token_expires_at) { should match_unixtime(User::REFRESH_TOKEN_EXPIRES_IN.from_now) }
      end
    end
  end

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

    before do
      @count = 0

      allow(ChatWork::Token).to receive(:refresh_access_token) { tokens }
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

      expect(ChatWork::Token).to have_received(:refresh_access_token).once
    end
  end
end
