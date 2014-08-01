class Picture < ActiveRecord::Base
  attr_accessible :description, :picture_file, :picture_file_file_name, :created_at, :filepicker_url

  validates :album_id, presence: true
  validates :user_id, presence: true
  # validates :picture_file, :attachment_presence => true
  validates :filepicker_url, presence: true

  belongs_to :album
  belongs_to :user
  has_attached_file :picture_file, :styles => { :large => "800x800>", :medium => "250x250>", :thumb => "250x250#" }, :default_url => "/images/lolcat_404.jpg"
  has_many :comments, dependent: :destroy, as: :commentable

  # after_post_process :postprocess_image

  after_create :send_yo

  def is_filepicker_picture?
    self.picture_file.blank?
  end

  def date_time
    if self.taken_at.blank?
      self.created_at
    else
      self.taken_at
    end
  end

  def latitude_longitude
    if self.latitude.nil? || self.longitude.nil?
      nil
    else
      self.latitude + ':' + self.longitude
    end
  end

  def postprocess_image
    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:large])
    self.image_width_large = geo.width
    self.image_height_large = geo.height

    geo = Paperclip::Geometry.from_file(picture_file.queued_for_write[:medium])
    self.image_width_medium = geo.width
    self.image_height_medium = geo.height    

    exif = EXIFR::JPEG.new(picture_file.queued_for_write[:original].path)

    if exif.exif?

      unless exif.date_time.blank?
        self.taken_at = exif.date_time
      end

      unless exif.gps.blank?
        self.latitude = exif.gps.latitude
        self.longitude = exif.gps.longitude
      end

    end
  end

  def send_yo
    album.send_yo
  end
end
