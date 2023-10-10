class RegistrationsController < ::Devise::RegistrationsController
  protect_from_forgery with: :exception

  def create
    @user = User.new(user_params)
    data_url = params[:cropped_img]
    raise data_url.inspect
    if data_url.present?
      # Decode the data URL and save the image
      decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    end
    raise @user.inspect
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:avatar, :cropped_img)
  end
end
  