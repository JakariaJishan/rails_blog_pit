class RegistrationsController < ::Devise::RegistrationsController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def create
    @user = User.new(user_params)
    data_url = params[:user][:cropped_img]
    if data_url.present?
      decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
    end

    if @user.save
      sign_in(@user)
      @user.online = true
      flash[:notice] = "User created successfully"
      render json: @user
    else
      flash[:alert] = "Invalid Information"
      render json: @user.errors.full_messages
    end

  end

  def update
    @user = User.find(current_user.id)
      if @user.update_with_password(user_params)
        data_url = params[:user][:cropped_img]
        if data_url.present?
          decoded_image = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
          @user.avatar.attach(io: StringIO.new(decoded_image), filename: 'avatar.png')
        end
        bypass_sign_in(@user)
        flash[:notice]="User updated successfully"
        render json: @user

      else
       @user.errors.full_messages.each do |msg|
         flash[:alert] = msg
       end
        render json: {error: @user.errors.full_messages}
      end

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:current_password,:avatar, :date, :phone_number)
  end
end
  