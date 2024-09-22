class SendConfirmationEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.send_confirmation_instructions
    # Do something later
  end
end
