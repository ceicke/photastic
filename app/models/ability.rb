class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.blank?
      false
    else
      can :create, Album
      can :manage, Album do |album|
        album.user_id == user.id || Member.where(:album_id => album.id, :user_id => user.id, :can_administer => true).size > 0
      end
      can :manage, Picture, :user_id => user.id
      can [:new, :create], Picture do |picture|
        Member.where(:album_id => picture.album_id, :user_id => user.id, :can_addphotos => true).size > 0
      end
      can :manage, User, :id => user.id
      can :manage, Member
    end
  end
end
