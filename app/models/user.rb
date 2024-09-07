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
  has_many :chats
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  has_many :questions
  has_many :answers
  has_many :saved_posts, dependent: :destroy

  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  # Outgoing friend requests
  has_many :sent_friendships, foreign_key: :sender_id, class_name: 'Friendship'
  has_many :sent_friends, through: :sent_friendships, source: :receiver

  # Incoming friend requests
  has_many :received_friendships, foreign_key: :receiver_id, class_name: 'Friendship'
  has_many :received_friends, through: :received_friendships, source: :sender

  # Scope for accepted friendships
  def friends
    sent_friends.merge(Friendship.where(status: 'accepted')) + received_friends.merge(Friendship.where(status: 'accepted'))
  end

  # Get pending sent friend requests
  def pending_sent_requests
    sent_friendships.where(status: 'pending')
  end

  # Get pending received friend requests
  def pending_received_requests
    received_friendships.where(status: 'pending')
  end

  def after_confirmation
    super
    WelcomeJob.perform_async(self.email)
  end

  # Fetch all users except friends and those with pending requests
  def non_friends
    # Get the IDs of users who are friends or have pending requests
    friends_ids = sent_friends.merge(Friendship.where(status: 'accepted')).pluck(:id) +
      received_friends.merge(Friendship.where(status: 'accepted')).pluck(:id)

    pending_request_ids = sent_friendships.where(status: 'pending').pluck(:receiver_id) +
      received_friendships.where(status: 'pending').pluck(:sender_id)

    all_related_ids = friends_ids + pending_request_ids

    User.where.not(id: all_related_ids).where.not(id: self.id)  # Exclude self
  end

  def check_for_badges
    Badge.all.each do |badge|
      case badge.name
      when "First Post"
        give_badge(badge) if posts.count >= 1
      when "Contributor"
        give_badge(badge) if posts.count >= 10
      when "Active Contributor"
        give_badge(badge) if posts.count >= 50
      when "Helpful"
        give_badge(badge) if likes_received.count >= 10
      when "Super Helpful"
        give_badge(badge) if likes_received.count >= 50
      when "First Answer"
        give_badge(badge) if answers.count >= 1
      when "Top Answerer"
        give_badge(badge) if answers.count >= 10
      when "Question Master"
        give_badge(badge) if questions.count >= 5
      end
    end
  end

  def give_badge(badge)
    unless badges.include?(badge)
      badges << badge
    end
  end

  def likes_received
    posts.joins(:likes).distinct
  end

  def answers
    Answer.where(user: self)
  end

  def questions
    Question.where(user: self)
  end
end
