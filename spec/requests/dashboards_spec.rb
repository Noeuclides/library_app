require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/dashboards/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /librarian" do
    it "returns http success" do
      get "/dashboards/librarian"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /member" do
    it "returns http success" do
      get "/dashboards/member"
      expect(response).to have_http_status(:success)
    end
  end

end
