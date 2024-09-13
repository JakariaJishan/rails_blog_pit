class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # Set expires_at to 24 hours from now on creation
  before_create :set_expiry

  private

  def set_expiry
    self.expires_at = 24.hours.from_now
  end
end
