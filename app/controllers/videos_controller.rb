class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    video = Video.new(video_params)
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
    params.require(:video).permit(:title, :description, :url, :category, :availability)
  end

end