class ReelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reels = Reel.recent.includes(:user)
  end

  def show
    @reel = Reel.find(params[:id])
  end

  def new
    @reel = current_user.reels.build
  end

  def create
    @reel = current_user.reels.build(reel_params)

    if @reel.save
      GenerateThumbnailJob.perform_later(@reel)  # Generate thumbnail
      flash[:notice] = "Video uploaded successfully!"
      redirect_to reels_path
    else
      flash[:alert] = "Error uploading Video."
      render :new
    end
  end

  def destroy
    @reel = Reel.find(params[:id])
    if @reel.user == current_user
      @reel.destroy
      flash[:notice] = "Video deleted successfully."
    else
      flash[:alert] = "You are not authorized to delete this Video."
    end
    redirect_to reels_path
  end

  private

  def reel_params
    params.require(:reel).permit(:title, :description, :video)
  end
end
