require 'rails_helper'

RSpec.feature 'New video', :type => :feature do
  let!(:user) { create(:user) }
  let!(:video_permission) { create(:video, :user_id => 10) }

  scenario "User cannot delete a video if they do not own it" do
    page.set_rack_session(user_id: user.id)

    visit video_path(video_permission)
    expect(page).not_to have_text("Delete Video")
  end

  scenario "User can delete a video" do
   page.set_rack_session(user_id: user.id)

    visit "/videos/new"
      fill_in "video_title", :with => "Test Title"
      fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
      click_button "Create Video"

      click_on "Delete Video"

      expect(page).not_to have_text("Test Title")
  end

end