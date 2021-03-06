class Album < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true
  validates :subdomain, uniqueness: true

  belongs_to :user
  belongs_to :picture
  has_many :pictures, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :album_members, dependent: :destroy
  has_many :users, through: :members

  def thumb_picture
    if picture.blank?
      if pictures.size > 0
        pictures.first
      end
    else
      picture
    end
  end

  def thumb_picture_url
    if thumb_picture.nil?
      ActionController::Base.helpers.asset_path('empty_gallery.png')
    else
      thumb_picture.picture_file.url(:thumb)
    end
  end

  def cover_picture
    thumb_picture_url
  end

  def as_json(options={})
    super(:methods => [:cover_picture])
  end
end
