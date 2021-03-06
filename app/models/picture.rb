class Picture < ActiveRecord::Base
  include PgSearch
  multisearchable against: :description, :using => {
    :tsearch => {:prefix => true},
    :trigram => true
  }

  validates :album_id, presence: true
  validates :picture_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_attached_file :picture_file, :styles => { :large => "800x800>", :medium => "250x250>", :thumb => "250x250#" }, :default_url => "/images/lolcat_404.jpg"
  has_many :comments, dependent: :destroy, as: :commentable

  after_post_process :postprocess_image

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
  end

  def uploader_name
    if user.blank?
      if guest_user.blank?
        ''
      else
        guest_user
      end
    else
      if user.nickname.blank?
        ''
      else
        user.nickname
      end
    end
  end

  def picture_url_large
    picture_file.url(:large)
  end

  def picture_url_medium
    picture_file.url(:medium)
  end

  def picture_url_thumb
    picture_file.url(:thumb)
  end

  def as_json(options={})
    super(:methods => [:picture_url_large, :picture_url_medium, :picture_url_thumb])
  end
end
