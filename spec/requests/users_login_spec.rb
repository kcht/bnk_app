require 'rails_helper'
require 'pry'
RSpec.describe "UserLogins", type: :request do
  describe "GET /login" do
    before do
      FactoryGirl.create(:user, email: 'x@x.pl', password: 'test', password_confirmation: 'test')
    end


    it 'flash message appears after unsuccessful login', :aggregate_failures, :skip => true  do
      #todo: fix 422 error - jsons in session controller to be added?
      get login_path
      expect(response).to have_http_status(200)
      expect(self).to render_template("new")

      post login_path, params: { session: { email: "", password: "" } }
      expect(self).to render_template("new")

      expect(flash.empty?).not_to be true
      get root_path
      expect(flash.empty?).to be true
    end
  end
end
