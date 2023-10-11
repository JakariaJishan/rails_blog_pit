class RegistrationsController < ::Devise::RegistrationsController
  protect_from_forgery with: :exception

  def create
    @user = User.new(user_params)
    data_url = params[:user][:cropped_img]
    if data_url.present?
      # Decode the data URL and save the image
      decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    end

    respond_to do |format|
      if @user.save 
        format.html { redirect_to root_path }
        format.json { render json: @user }
      else
        # format.html { render :new } 
        format.json { render json: params[:user][:username] }
      end
    end
    # if @user.save
    #   redirect_to root_path
    #   render json: @user
    # else
    #   render json: @user
    # end
    # raise @user.inspect
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:avatar)
  end
end
  