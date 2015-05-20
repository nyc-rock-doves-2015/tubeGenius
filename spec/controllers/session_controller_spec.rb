require 'rails_helper'

RSpec.describe SessionsController do
  let!(:user) { User.create(name: "username", email: "user@testuser.com", password: 'password', password_confirmation: 'password')}

  describe 'GET #new' do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    it "redirects to the video index" do
      post :create, user:{name: user.name, password: user.password}
      expect(response).to redirect_to(videos_path)
    end

    it "does not set session id on error" do
      post :create, user:{name: user.name, password: "not_password"}
      expect(session[:user_id]).to eq(nil)
    end

    it "sets the user id with #session_in!" do
      post :create, user:{name: user.name, password: user.password}
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'DELETE #destroy' do
    it "redirects to new_user_path" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it "sets the user_id of session to nil" do
      post :create, user:{name: user.name, password: user.password}
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end
end