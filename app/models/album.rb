class Album < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :pictures
end
