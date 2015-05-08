require 'rails_helper'

RSpec.feature 'New video', :type => :feature do
 User.create(name: "test_user",
                password: "password",
                password_confirmation: "password")

  scenario "User creates a new video" do
   visit signin_path
   fill_in "user[name]", :with => "test_user"
   fill_in "user[password]", :with => "password"
   click_on "Sign In"
    visit "/videos/new"
      fill_in "Title", :with => "Test Title"
      click_button "Create Video"

      expect(page).to have_text("Test Title")
  end

  scenario "User sets the commentability status of a new video" do
    visit signin_path
    fill_in "user[name]", :with => "test_user"
    fill_in "user[password]", :with => "password"
    click_on "Sign In"

    visit "/videos/new"
     choose('video_availability_personal')
     click_button "Create Video"

      expect(page).to have_text("Personal")
  end
end