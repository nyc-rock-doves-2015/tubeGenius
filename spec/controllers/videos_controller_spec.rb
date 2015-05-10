require 'rails_helper'

RSpec.describe VideosController do
  let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

  it "renders the :new view" do
    get :new
    expect(response).to render_template("new")
  end

end