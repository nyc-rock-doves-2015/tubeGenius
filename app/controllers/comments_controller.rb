class CommentsController < ApplicationController
  def new
    @video = Video.find(params[:video_id])
    @comment = @video.comments.new
  end

  def create
    puts "*****************"
    puts params[:video_id]
    video = Video.find(params[:video_id])
    @comment = video.comments.new(comment_params)

    if @comment.save
      redirect_to video_path(video)
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :start_time, :end_time, :media_url, :media_type).merge(user_id: current_user)
  end
end
