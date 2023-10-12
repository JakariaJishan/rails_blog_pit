class Post < ApplicationRecord
  validates :title, presence:true
  validates :content, presence:true
  validates :post_image, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :post_image
end
