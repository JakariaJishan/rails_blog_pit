class WelcomeJob
  include Sidekiq::Job
  queue_as :default

  def perform(email)
    # puts "I am #{name}, running my first job at #{age}"
    #any other valid Ruby/Rails code goes here!
    UserMailer.example(User.new(email:email)).deliver_now
  end
end
