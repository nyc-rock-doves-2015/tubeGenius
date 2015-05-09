require 'rails_helper'

RSpec.feature 'New video', :type => :feature do
  let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

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