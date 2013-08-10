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

  def get_exif
    EXIFR::JPEG.new(picture_file.path)
  end

  def date_time
    if get_exif.exif?
      if get_exif.date_time.blank?
        created_at
      else
        get_exif.date_time
      end
    else
      created_at
    end
  end

  def latitude_longitude
    if get_exif.exif?
      if get_exif.gps.blank?
        nil
      else
        get_exif.gps.latitude + ":" + get_exif.gps.longitude
      end
    else
      nil
    end
  end

  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:large])
    self.image_width_large = geo.width
    self.image_height_large = geo.height

    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:medium])
    self.image_width_medium = geo.width
    self.image_height_medium = geo.height    
  end
end
