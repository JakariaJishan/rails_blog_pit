class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception

  def save_data_url

    session[:data_url] = params[:data_url]
    raise params.inspect
  end

  def create
    @user = User.new(user_params)
    
    # if data_url.present?
    #   # Decode the data URL and save the image
    #   decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
    #   @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    # end
    raise params.inspect
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
end
  