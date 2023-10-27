class UserMailer < ApplicationMailer
  def example(user)
    @user = user
    mail(to:@user.email, subject: "Welcome message")
  end
end
