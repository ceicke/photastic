class Album < ActiveRecord::Base
  attr_accessible :name, :picture_id, :passcode

  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :picture
  has_many :pictures, dependent: :destroy

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
end
