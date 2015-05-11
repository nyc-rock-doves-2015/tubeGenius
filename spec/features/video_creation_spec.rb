require 'rails_helper'

RSpec.feature 'New video', :type => :feature do
  let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

  scenario "User creates a new video" do
   page.set_rack_session(user_id: user.id)

    visit "/videos/new"
      fill_in "video_title", :with => "Test Title"
      fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
      click_button "Create Video"

      expect(page).to have_text("Test Title")
  end

  scenario "User sets the commentability status of a new video" do
    page.set_rack_session(user_id: user.id)

    visit "/videos/new"
     fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
     choose('video_availability_personal')
     click_button "Create Video"

     expect(page).to have_text("Personal")
  end

  scenario "User creates a video without a URL" do
    page.set_rack_session(user_id: user.id)

    visit "/videos/new"
     click_button "Create Video"

     expect(page).to have_selector("input[type=submit][value='Create Video']")
  end
end