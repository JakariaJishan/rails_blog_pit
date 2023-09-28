class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    return unless user.present?

    can :manage, Post, user: user
    can :manage, Comment, user:user
  end
end