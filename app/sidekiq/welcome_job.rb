class WelcomeJob
  include Sidekiq::Job
  queue_as :default

  def perform
    # puts "I am #{name}, running my first job at #{age}"
    #any other valid Ruby/Rails code goes here!
    UserMailer.example(User.new(email:"jack@gmail.com")).deliver_now
  end
end
