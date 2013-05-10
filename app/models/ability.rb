class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Album, :user_id => user.id
    can :manage, Picture, :user_id => user.id
    can :manage, User, :id => user.id
  end
end
