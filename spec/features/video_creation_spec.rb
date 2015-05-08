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
      fill_in "video_title", :with => "Test Title"
      fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
      click_button "Create Video"

      expect(page).to have_text("Test Title")
  end

  scenario "User sets the commentability status of a new video" do
    visit signin_path
    fill_in "user[name]", :with => "test_user"
    fill_in "user[password]", :with => "password"
    click_on "Sign In"

    visit "/videos/new"
     fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
     choose('video_availability_personal')
     click_button "Create Video"

     expect(page).to have_text("Personal")
  end

  scenario "User creates a video without a URL" do
    visit signin_path
    fill_in "user[name]", :with => "test_user"
    fill_in "user[password]", :with => "password"
    click_on "Sign In"

    visit "/videos/new"
     click_button "Create Video"

     expect(page).to have_selector("input[type=submit][value='Create Video']")
  end
end