require 'rails_helper'

RSpec.feature 'Edit video', :type => :feature do
 let!(:user) { create(:user) }
 let!(:video) { create(:video) }
 let!(:video_permission) { create(:video, :user_id => 10) }

  scenario "User can edit a video" do
   page.set_rack_session(user_id: user.id)

   visit video_path(video)
   click_on "Edit Video"

   fill_in "edit_title", :with => "Edited Title"
   click_button "Save Changes"

   expect(page).to have_text("Edited Title")
  end

  scenario "Edit video failure reloads edit page" do
   page.set_rack_session(user_id: user.id)

   visit video_path(video)
   click_on "Edit Video"

   fill_in "edit_title", :with => ""
   click_button "Save Changes"

   expect(page).to have_selector("input[type=submit][value='Save Changes']")
  end

  scenario "User cannot edit a video if they do not own it" do
   page.set_rack_session(user_id: user.id)

   visit video_path(video_permission)
   expect(page).not_to have_text("Edit Video")
  end

end