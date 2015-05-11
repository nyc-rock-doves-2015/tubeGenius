require 'rails_helper'

describe Video do

  before(:each) do
    @video = build(:video)
  end

  it "should have valid factory" do
    expect(@video).to be_valid
  end

  it "is invalid without a title" do
    expect{create(:video, :title => nil)}.to raise_error
  end


end