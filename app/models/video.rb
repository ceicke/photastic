class Video < ActiveRecord::Base
  attr_accessible :description, :video_file, :video_file_file_name, :created_at

  validates :album_id, presence: true
  validates :user_id, presence: true
  validates :video_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable

  after_create :send_yo

  has_attached_file :video_file, :styles => {
    :thumb => { :geometry => "250x250>", :format => 'jpg', :time => 2 }
  }, :processors => [:ffmpeg]

  def send_yo
    unless album.yo_api_key.blank?
      Net::HTTP.post_form(URI('http://api.justyo.co/yoall/'), 'api_token' => album.yo_api_key, 'link' => video_file.url)
    end
  end

end
