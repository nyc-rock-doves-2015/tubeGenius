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
    visit root_path
    fill_in "signup_name", :with => "test_user"
    fill_in "signup_password", :with => "password"
    fill_in "signup_password_confirmation", :with => "password"
    click_button "Sign Up"

    expect(page).to have_text("test_user")
  end

  scenario "Non-existant user cannot sign in" do
    visit root_path
    fill_in "signin_name", :with => "whoisthis"
    fill_in "signin_password", :with => "password"
    click_button "Sign In"

    expect(page).to have_button("Sign In")
  end


  scenario "Bad sign up redirects to sign up" do
    visit root_path
    fill_in "signup_name", :with => "test_user"
    fill_in "signup_password", :with => "password"
    fill_in "signup_password_confirmation", :with => "not_password"
    click_button "Sign Up"

    expect(page).to have_text "Password confirmation"
  end

end