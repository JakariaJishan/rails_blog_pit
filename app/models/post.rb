class Post < ApplicationRecord

  # validates :post_images, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_one_attached :post_image
  has_many_attached :post_images
  has_many :saved_posts, dependent: :destroy

  after_create :check_user_badges

  private

  def check_user_badges
    user.check_for_badges
  end
end
