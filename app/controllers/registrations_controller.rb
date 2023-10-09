class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        # raise params.inspect
        resource.avatar.attach(params[:user][:avatar]) if params[:user][:avatar].present?
      end
    end
  end
  