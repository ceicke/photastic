class Video < ActiveRecord::Base
  validates :album_id, presence: true
  validates :user_id, presence: true
  validates :video_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable

  after_create :send_yo

  has_attached_file :video_file, :styles => {
    :thumb => { :geometry => "250x250>", :format => 'jpg', :time => 2 }
  }, :processors => [:transcoder]

  def heywatch_encode
    username = ENV['SERVER_USERNAME']
    password = ENV['SERVER_PASSWORD']
    heywatch_api_key = ENV['HEYWATCH_API_KEY']

    FileUtils.mkdir_p "/home/photastic/encoded_videos/#{album.id}/#{id}"

    conf = ""

    conf << "set source = #{video_file.url}"
    conf << "\n"
    conf << "set webhook = https://app.heywatch.com/pings/ebfe706b/ceicke"
    conf << "\n"
    conf << "-> mp4_720p = sftp://#{username}:#{password}@photasti.cc:22/home/photastic/encoded_videos/#{album.id}/#{id}/ios.mp4"
    conf << "\n"
    conf << "-> android_720p = sftp://#{username}:#{password}@photasti.cc:22/home/photastic/encoded_videos/#{album.id}/#{id}/andoid.mp4"
    conf << "\n"
    conf << "-> flash_360p = sftp://#{username}:#{password}@photasti.cc:22/home/photastic/encoded_videos/#{album.id}/#{id}/flash.flv"
    conf << "\n"
    conf << "-> jpg_250x250 = sftp://#{username}:#{password}@photasti.cc:22/home/photastic/encoded_videos/#{album.id}/#{id}/thumb.jpg, number=1"
    conf << "\n"

    job = HeyWatch.submit(conf, heywatch_api_key)

    if job["status"] == "ok"
      puts job["id"]
    else
      raise "#{job["error_code"]} - #{job["error_message"]}"
    end

  end

  def send_yo
    unless album.yo_api_key.blank?
      Net::HTTP.post_form(URI('http://api.justyo.co/yoall/'), 'api_token' => album.yo_api_key, 'link' => video_file.url)
    end
  end

end
