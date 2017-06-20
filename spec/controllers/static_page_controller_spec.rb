require 'rails_helper'

RSpec.describe StaticPageController, type: :controller do
  let(:base_title) { 'BNK App' }
  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #help" do
    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    it "return http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

end
