require 'rails_helper'

RSpec.describe ApplicationController do

  describe "POST #session_in!" do
    before :each do
      user = User.create!(name: "test_user36",
                          password: "password",
                          password_confirmation: "password")
    end

    it "creates a new user session" do
      post :session_in!, user: user
      expect(session[:user_id]).to eq(user.id)
    end
  end
end