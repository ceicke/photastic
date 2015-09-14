class Ability
  include CanCan::Ability

  def initialize(user)

    if user.blank?
      false
    else
      can :create, Album
      can :manage, Album do |album|
        album.user_id == user.id || AlbumMember.where(:album_id => album.id, :user_id => user.id, :can_administer => true).size > 0
      end
      can :manage, Picture, :user_id => user.id
      can [:manage], Picture do |picture|
        AlbumMember.where(:album_id => picture.album_id, :user_id => user.id, :can_administer => true).size > 0
      end
      can [:index, :new, :create, :show], Picture do |picture|
        AlbumMember.where(:album_id => picture.album_id, :user_id => user.id, :can_addphotos => true).size > 0
      end
      can :manage, Video, :user_id => user.id
      can [:manage], Video do |video|
        AlbumMember.where(:album_id => video.album_id, :user_id => user.id, :can_administer => true).size > 0
      end
      can [:new, :create, :show], Video do |video|
        AlbumMember.where(:album_id => video.album_id, :user_id => user.id, :can_addphotos => true).size > 0
      end
      can :manage, User, :id => user.id
      can :manage, AlbumMember
    end
  end
end
