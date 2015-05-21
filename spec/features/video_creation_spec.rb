require 'rails_helper'

RSpec.feature 'New video', :type => :feature do
  let!(:user) { create(:user) }

  scenario "User creates a new video" do
   page.set_rack_session(user_id: user.id)

   visit root_path
    click_on "Create a Video"
    fill_in "video_title", :with => "Test Title"
    fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
    click_button "createNewVideo"

    expect(page).to have_text("Test Title")
  end

  scenario "User sets the commentability status of a new video" do
    page.set_rack_session(user_id: user.id)

    visit root_path
    click_on "Create a Video"
     fill_in "video_title", :with => "Test Title"
     fill_in "video_url", :with => "https://www.youtube.com/watch?v=ckpwSAv5we8"
     choose('video_availability_personal')
     click_button "Create Video"

     expect(page).to have_text("Personal")
  end

  scenario "User creates a video without a URL" do
    page.set_rack_session(user_id: user.id)

    visit root_path
    click_on "Create a Video"
    fill_in "video_title", :with => "Test Title"
    click_button "Create Video"

    expect(page.status_code).to eq(400)
  end
end