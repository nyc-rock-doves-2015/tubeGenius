class CommentsController < ApplicationController
  def new
    @video = Video.find(params[:id])
    @comment = @video.comments.new
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to video_path(@comment.video)
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :start_time, :end_time, :media_url, :media_type).merge(user: current_user)
  end
end
