require 'rails_helper'

RSpec.feature 'New comment', type: :feature do

  let!(:user) { create(:user) }
  let!(:video) { create(:video) }

  scenario "User creates a new comment" do
   page.set_rack_session(user_id: user.id)

   visit new_video_comment_path(video)
     fill_in "comment[content]", with: "test content"
     click_button "Submit"
     visit video_path(video, format: :json)
     expect(page).to have_text('test content')
  end

end