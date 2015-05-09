require 'rails_helper'

RSpec.feature 'Edit video', :type => :feature do
 let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

  scenario "User can edit a video" do
   page.set_rack_session(user_id: user.id)

    visit "/videos/new"
      fill_in "video_title", :with => "Test Title"
      fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
      click_button "Create Video"

      click_on "Edit Video"

      fill_in "video_title", :with => "Edited Title"
      click_button "Save Changes"

      expect(page).to have_text("Edited Title")
  end

  scenario "Edit video failure reloads edit page" do
   page.set_rack_session(user_id: user.id)

    visit "/videos/new"
      fill_in "video_title", :with => "Test Title"
      fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
      click_button "Create Video"

      click_on "Edit Video"

      fill_in "video_title", :with => ""
      click_button "Save Changes"

      expect(page).to have_selector("input[type=submit][value='Save Changes']")
  end

end