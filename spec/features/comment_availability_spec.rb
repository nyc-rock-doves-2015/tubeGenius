require 'rails_helper'

RSpec.feature 'Comment Availability', :type => :feature do

  let!(:user) { create(:user) }
  let!(:video) { create(:video) }
  let!(:video_permission) { create(:video, :user_id => 10, :availability => "Personal") }
  let!(:video_owner) { create(:video, :user_id => user.id, :availability => "Personal") }


  scenario "User cannot add a comment to public a video if not logged in" do
    visit video_path(video)
    expect(page).not_to have_text("Add a comment")
  end

  scenario "User cannot add a comment to personal a video if not the owner" do
    page.set_rack_session(user_id: user.id)
    visit video_path(video_permission)
    expect(page).not_to have_text("Add a comment")
  end

  scenario "User can add a comment to public a video if logged in" do
    page.set_rack_session(user_id: user.id)

    visit video_path(video)
    expect(page).to have_text("Add a comment")
  end

  scenario "User can add a comment to a personal video if the owner" do
    page.set_rack_session(user_id: user.id)

    visit video_path(video_owner)
    expect(page).to have_text("Add a comment")
  end

end