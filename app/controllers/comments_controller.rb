class CommentsController < ApplicationController
  # before_action :authenticate_user!, except: [:show, :index]

  def new
    @video = Video.find(params[:video_id])
    @comment = @video.comments.new
  end

  def index
    video = Video.find(params[:video_id])
    @comments = video.comments
  end

  def create
    video = Video.find(params[:video_id])
    @comment = video.comments.new(comment_params)

    if @comment.save
      redirect_to video_path(video)
    else
      flash[:notice] = "Sorry, your comment didn't save"
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])
    video = comment.video
    comment.destroy

    redirect_to video_path(video)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :start_time, :end_time, :media_url, :media_type).merge(user_id: current_user)
  end
end
