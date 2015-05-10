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
end