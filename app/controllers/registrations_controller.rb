class RegistrationsController < ::Devise::RegistrationsController
  protect_from_forgery with: :exception

  def create
    @user = User.new(user_params)
    data_url = params[:user][:cropped_img]
    if data_url.present?
      decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    end

    if @user.save
      sign_in(@user)
      render json: @user
    else
      puts @user.errors.full_message
      render json: @user
    end

  end

  def update

    @user = User.find_by(email: params[:user][:email])
    data_url = params[:user][:cropped_img]
    if data_url.present?
      decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    end
    if @user.update(user_params)
      # sign_in(@user)
      puts "success"
      render json: @user
    else
      puts "failed"
      render json: @user
    end
    super
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:avatar)
  end
end
  