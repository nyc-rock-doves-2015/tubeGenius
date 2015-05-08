require 'rails_helper'

describe ApplicationController do

  describe "POST session_in!" do
    user = User.create!(name: "test_user36",
                        password: "password",
                        password_confirmation: "password")
    it "creates a new user session" do
      post :session_in!, user: user
      expect(session[:user_id]).to eq(user.id)
    end

  end

end