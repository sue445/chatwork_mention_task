RSpec.describe AuthController, type: :controller do
  describe "GET #callback", :time_stop do
    subject(:callback) { get :callback }

    before do
      allow(controller).to receive(:auth_hash) { auth_hash }
    end

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
            profile: "http://github.com/sue445"
          }
        },
        credentials: {
          token: "access_token",
          refresh_token: "refresh_token",
          expires_at: 1_510_504_991,
          expires: true
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
            login_mail: "sue445@example.com"
          }
        }
      }
    end

    it { should have_http_status(302) }

    it { expect { subject }.to change { User.count }.by(1) }

    describe "user is created" do
      subject do
        callback
        User.last
      end

      its(:account_id)               { should eq 1_111_111 }
      its(:room_id)                  { should eq 2_222_222 }
      its(:name)                     { should eq "sue445" }
      its(:avatar_image_url)         { should eq "https://appdata.chatwork.com/avatar/ico_default_blue.png" }
      its(:access_token)             { should eq "access_token" }
      its(:refresh_token)            { should eq "refresh_token" }
      its(:access_token_expires_at)  { should match_unixtime(1_510_504_991.seconds.from_now) }
      its(:refresh_token_expires_at) { should match_unixtime(User::REFRESH_TOKEN_EXPIRES_IN.from_now) }
    end
  end
end
