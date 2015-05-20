class VideosController < ApplicationController

  before_action :authenticate_user!, only: [:new, :destroy, :edit]

  def show
    @video = Video.find(params[:id])
    @comment = @video.comments.new
    @comments = @video.comments

    respond_to do |format|
      format.html { render :show }
      format.json {
        render json: [
          @video.url,
          @comments.where.not(start_time: nil, end_time: nil).
            as_json({:include => { :user => { :methods => :gravatar_url, only: [:id, :name] }}})
        ]
      }
    end

  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(video_params)
      redirect_to video_path(@video)
    else
      redirect_to edit_video_path(@video)
    end
  end

  def destroy
    video = Video.find(params[:id])
    video.destroy
    redirect_to root_path
  end

  def create
    user =  User.find(session[:user_id])
    video = user.videos.build(video_params)
    if video.save
      flash[:notice] = "Your video has been posted!"
      redirect_to video_path(video)
    else
      flash[:notice] = "Sorry, your video didn't save. Please try again."
      redirect_to new_video_path
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :url, :category, :availability, :user_id)
  end

end
