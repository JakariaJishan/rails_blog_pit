class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :date, presence:true
  has_one_attached :avatar
  has_many :posts
  has_many :comments, dependent: :destroy
end
