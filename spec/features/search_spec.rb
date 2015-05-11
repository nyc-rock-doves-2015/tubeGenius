require 'rails_helper'

RSpec.feature 'Search', :type => :feature do

  let!(:user) { create(:user) }

  scenario "User searches for an item"
end
