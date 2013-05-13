class Member < ActiveRecord::Base
  attr_accessible :album_id, :can_addphotos, :can_administer, :user_id

  belongs_to :album
  belongs_to :user
end
