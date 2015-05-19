require 'rails_helper'

RSpec.feature 'New comment', type: :feature do

  let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

  let!(:video) { Video.create(title: "test", url: "https://www.youtube.com/watch?v=ckpwSAv5we8", user_id: user.id)}

  scenario "User creates a new comment" do
   page.set_rack_session(user_id: user.id)

   visit new_video_comment_path(video)
     fill_in "comment[content]", with: "test content"
     click_button "Submit"
     visit video_path(video, format: :json)
     expect(page).to have_text('test content')
  end

end