require 'spec_helper'

describe SessionsController do
  
  describe 'GET #new' do
    it "renders the :new view"
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "creates a new session with the user's id"
      it "redirects to the user's :show page"
    end

    context 'with invalid attributes' do
      it "does not create a new session"
      it "flashes an error message"
    end
  end

  describe 'DELETE #destroy' do
    it "signs a user out"
    it "redirects to root_path"
  end
end