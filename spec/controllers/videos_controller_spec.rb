require 'rails_helper'

RSpec.describe VideosController do
  let(:user) { create(:user) }

  it "renders the :new view" do
    get :new
    expect(response).to render_template("new")
  end

end