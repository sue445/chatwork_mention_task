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
      its(:refresh_token_reminded_at) { should eq nil }
    end

    context "when user is registered" do
      before do
        create(
          :user,
          account_id: 1_111_111,
          room_id: room_id,
          refresh_token: refresh_token,
          refresh_token_expires_at: refresh_token_expires_at,
          refresh_token_reminded_at: refresh_token_reminded_at,
        )
      end

      let(:room_id) { 2_222_222 }
      let(:refresh_token_expires_at)  { 1.day.ago }
      let(:refresh_token_reminded_at) { 2.day.ago }

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
        its(:refresh_token_expires_at) { should match_unixtime(refresh_token_expires_at) }
        its(:refresh_token_reminded_at) { should eq refresh_token_reminded_at }
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
        its(:refresh_token_reminded_at) { should eq nil }
      end
    end
  end
end
