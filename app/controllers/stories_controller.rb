class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = Story.where('expires_at > ?', Time.now)
  end

  def show
    @story = Story.find(params[:id])
  end
  def new
    @story = current_user.stories.build
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      flash[:notice] = "Story created successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Failed to create story."
      render :new
    end
  end

  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      flash[:notice] = "Story deleted successfully"
      redirect_to root_path
    else
      flash[:alert] = "Failed to delete story"
      redirect_to story_path(@story), status: :unprocessable_entity
    end
  end

  private

  def story_params
    params.require(:story).permit(:image)
  end
end
