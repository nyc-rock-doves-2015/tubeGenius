require 'rails_helper'

describe SessionsController do
  
  describe 'GET #new' do
    it "renders the :new view"do
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "creates a new session with the user's id"do
      end
      it "redirects to the user's :show page"do
      end
    end

    context 'with invalid attributes' do
      it "does not create a new session"do
      end
      it "flashes an error message"do
      end
    end
  end

  describe 'DELETE #destroy' do
    it "signs a user out" do
    end
    it "redirects to root_path"do
    end
  end
end