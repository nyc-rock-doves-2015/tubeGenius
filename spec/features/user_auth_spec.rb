require 'rails_helper'

RSpec.feature 'User', :type => :feature do
  let(:user) { create(user) }

  scenario "User can visit sign up page" do
    visit "/signup"
    expect(page).to have_text("Sign Up")
  end

  scenario "User can visit sign in page" do
    visit "/signin"
    expect(page).to have_text("Sign In")
  end

  scenario "User can sign up" do
    visit "/signup"
    fill_in "user_name", :with => "test_user"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Sign Up"

    expect(page).to have_text("TubeGenius Profile")
  end
end