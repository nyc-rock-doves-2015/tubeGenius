require 'rails_helper'

RSpec.describe VideosController do
  let(:user) { create(:user) }
  let(:video) { create(:video) }

  context "visitors" do
    it "redirects to signin path when trying to access new video" do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

end