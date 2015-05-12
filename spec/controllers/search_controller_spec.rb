require 'rails_helper'

RSpec.describe SearchController do

  describe 'GET #new' do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :noresults
    end
  end

end