class Post < ApplicationRecord
  validates :title, presence:true
  validates :content, presence:true
  validates :post_images, presence: true,content_type: ['image/png', 'image/jpg', 'image/jpeg']

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_one_attached :post_image
  has_many_attached :post_images
end
