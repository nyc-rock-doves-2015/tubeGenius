require 'rails_helper'

describe SessionsController do
  
  describe 'GET #new' do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "redirects to the user's :show page" do
      user = User.create!(name: "test_user33",
                          password: "password",
                          password_confirmation: "password")
      post :create, user:{name: user.name, password: user.password}
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'DELETE #destroy' do
    it "redirects to new_user_path" do
      delete :destroy
      expect(response).to redirect_to(new_user_path)
    end
  end
end