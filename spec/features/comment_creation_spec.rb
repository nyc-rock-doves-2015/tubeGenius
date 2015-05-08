require 'rails_helper'

RSpec.feature 'New comment', :type => :feature do

    user = User.create(name: "test_user",
                       password: "password",
                       password_confirmation: "password")

    video = Video.create(title: "test",
                               url: "https://www.youtube.com/watch?v=ckpwSAv5we8",
                               user_id: 1)

  scenario "User creates a new comment" do
   visit signin_path
     fill_in "user[name]", :with => "test_user"
     fill_in "user[password]", :with => "password"
     click_on "Sign In"

   visit new_video_comment_path(video)
     fill_in "comment[content]", :with => "test content"
     click_button "Submit"
     visit video_json_path(video)
     expect(page).to have_text('test content')
  end

end