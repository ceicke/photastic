class Picture < ActiveRecord::Base
  attr_accessible :description, :picture_file, :picture_file_file_name

  validates :album_id, presence: true
  validates :user_id, presence: true
  validates :picture_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_attached_file :picture_file, :styles => { :large => "800x800>", :medium => "250x250>", :thumb => "250x250#" }
end
