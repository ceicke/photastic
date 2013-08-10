class Picture < ActiveRecord::Base
  attr_accessible :description, :picture_file, :picture_file_file_name

  validates :album_id, presence: true
  validates :user_id, presence: true
  validates :picture_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_attached_file :picture_file, :styles => { :large => "800x800>", :medium => "250x250>", :thumb => "250x250#" }, :default_url => "/images/lolcat_404.jpg"
  has_many :comments, dependent: :destroy

  after_post_process :save_image_dimensions

  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:large])
    self.image_width_large = geo.width
    self.image_height_large = geo.height

    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:medium])
    self.image_width_medium = geo.width
    self.image_height_medium = geo.height    
  end
end
