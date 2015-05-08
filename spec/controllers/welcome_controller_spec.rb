require 'rails_helper'

RSpec.describe WelcomeController do
  context "it renders the index view" do
    it "should respond with a 200" do
      get :index
      expect(response).to be_success
    end
  end
end