class CommentsController < ApplicationController
  # before_action :authenticate_user!, except: [:show, :index]

  def new
    if params[:parent_id]
      @comment = Comment.find(params[:parent_id])
      @subcomment = @comment.comments.new
    else
      @video = Video.find(params[:video_id])
      @comment = @video.comments.new
    end
  end

  def index
    @video = Video.find(params[:video_id])
    @comments = @video.static_comments
  end

  def edit
    video = Video.find(params[:video_id])
    @comment = video.comments.find(params[:id])
  end

  def update
    video = Video.find(params[:video_id])
    @comment = video.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to video_path(video)
    else
      render :edit
    end
  end

  def create
    if params[:comment_id]
      @parent_comment = Comment.find(params[:comment_id])
      @comment = @parent_comment.comments.build(comment_params)
    else
      video = Video.find(params[:video_id])
      @comment = video.comments.build(comment_params)
    end

    if @comment.save
      current_user.comments << @comment

      if request.xhr?
        new_comment = @comment.as_json({:include => { :user => { :methods => :gravatar_url }}})
        render json: new_comment
      else
        redirect_to video_path(@comment.find_video_parent)
      end
    else
      if request.xhr?
        flash[:notice] = "Sorry, your comment didn't save"
      end
      flash[:notice] = "Sorry, your comment didn't save"
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end

  def destroy
    comment = Comment.find(params[:id])
    @notification = Notification.where(comment_id: comment.id)
    if @notification.nil?
      @notification.destroy
    end
    comment.destroy if comment.editable_by?(current_user)
    render text: "ok"
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :start_time, :end_time, :media_url, :media_type).merge(user_id: current_user)
  end
end
