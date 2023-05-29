require 'rails_helper'

RSpec.describe "MessageMailers", type: :request do
  describe "GET /admin_list" do
    it "returns http success" do
      get "/message_mailer/admin_list"
      expect(response).to have_http_status(:success)
    end
  end

end
