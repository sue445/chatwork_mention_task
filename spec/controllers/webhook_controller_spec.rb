require 'rails_helper'

RSpec.describe WebhookController, type: :controller do

  describe "GET #mention" do
    it "returns http success" do
      get :mention
      expect(response).to have_http_status(:success)
    end
  end

end
