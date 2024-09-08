class Reel < ApplicationRecord
  belongs_to :user
  has_one_attached :video

  validates :title, presence: true
  validates :video, presence: true, content_type: ['video/mp4', 'video/quicktime']

  # Define scopes to order reels (e.g., latest first)
  scope :recent, -> { order(created_at: :desc) }
end

