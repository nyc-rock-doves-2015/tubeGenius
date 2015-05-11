require 'rails_helper'

RSpec.describe CommentsController do

  let(:video) { create(:video) }
  let(:user) { create(:user) }

  describe 'GET #new' do
    it "renders the :new view"do
    get :new, :video_id => video.id
    expect(response).to render_template("new")
    end
  end

  describe 'GET index' do
    it "assigns @comments" do
      comment = video.comments.create(content: "yolo")
      get :index, :video_id => video.id
      expect(assigns(:comments)).to eq([comment])
  end

    it "renders the index template" do
      get :index, :video_id => video.id
      expect(response).to render_template("index")
    end
  end

  describe 'POST create' do
    it "creates a new comment" do
      session[:user_id] = user.id
      post :create, {:video_id => video.id, comment: {content: "yolo4lyfe"}, user_id: user.id}
      assert_response :redirect
    end

    it "does not create a new comment if content is empty" do
      post :create, :video_id => video.id, comment: {media_url: "www.google.com"}
      expect(response).to render_template("new")
    end
  end

  describe 'GET show' do
    it "displays a comment" do
      comment = video.comments.create(content: "yolo")
      get :show, video_id: video.id, id: comment.id
      expect(response).to render_template("show")
    end
  end

  describe 'DELETE' do
    it "deletes a comment" do
      comment = video.comments.create(content: "yolo")
      expect {delete :destroy, {video_id: video.id, id: comment.id}}.to change(Comment, :count).by(-1)
    end
  end
end
