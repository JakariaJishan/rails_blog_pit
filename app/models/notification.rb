class Notification < ApplicationRecord
  belongs_to :user

  after_create_commit do
    ActionCable.server.broadcast('notification', {user: user, message: self.message, read: self.read, id: self.id })
  end
end
