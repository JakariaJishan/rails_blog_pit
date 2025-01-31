class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender_id, uniqueness: { scope: :receiver_id, message: "Friend request already sent" }

  # Friendship statuses
  STATUSES = ['pending', 'accepted', 'declined']
end
