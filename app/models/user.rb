class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :date, presence:true
  validates :avatar, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def after_confirmation
    super
    WelcomeJob.perform_async
  end
end
