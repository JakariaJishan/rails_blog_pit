class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :manage, Post, user: user
    can :manage, Comment, user:user
    can :manage, Like, user:user
    can :manage, Question, user_id: user.id
    can :manage, Answer, user_id: user.id
    can :read, Question
    can :read, Answer
    can :manage, Reel, user_id: user.id
    can :manage, Story, user_id: user.id
  end
end