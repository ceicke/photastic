class Video < ActiveRecord::Base
  include PgSearch
  multisearchable against: :description, :using => {
    :tsearch => {:prefix => true},
    :trigram => true
  }

  validates :album_id, presence: true
  validates :video_file, :attachment_presence => true

  belongs_to :album
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable

  after_create :send_yo
  after_save :heywatch_encode

  has_attached_file :video_file, :styles => {
    :thumb => { :geometry => "250x250>", :format => 'jpg', :time => 2 }
  }, :processors => [:transcoder]

  def heywatch_encode
    username = ENV['SERVER_USERNAME']
    password = ENV['SERVER_PASSWORD']
    heywatch_api_key = ENV['HEYWATCH_API_KEY']

    current_dir = Dir.pwd
    target_dir = current_dir + '/app/shared/public/system/videos_encoded'

    FileUtils.mkdir_p "#{target_dir}/#{album.id}/#{id}"

    conf = ""

    conf << "set source = http://photasti.cc/#{video_file.url}"
    conf << "\n"
    conf << "set webhook = http://photasti.cc/video_callback/callback?video_id=#{id}"
    conf << "\n"
    conf << "-> mp4_720p = sftp://#{username}:#{password}@photasti.cc:22#{target_dir}/#{album.id}/#{id}/ios.mp4"
    conf << "\n"
    conf << "-> flash_360p = sftp://#{username}:#{password}@photasti.cc:22#{target_dir}/#{album.id}/#{id}/flash.flv"
    conf << "\n"
    conf << "-> jpg_250x = sftp://#{username}:#{password}@photasti.cc:22#{target_dir}/#{album.id}/#{id}/thumb.jpg, number=1"
    conf << "\n"

    job = HeyWatch.submit(conf, heywatch_api_key)

    if job['status'] != 'ok'
      raise "#{job["error_code"]} - #{job["error_message"]}"
    end

  end

  def set_encoded!
    update_column('encoded',true)
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

  def send_yo
    if Rails.env.production? && !album.yo_api_key.blank?
      Net::HTTP.post_form(URI('http://api.justyo.co/yoall/'), 'api_token' => album.yo_api_key, 'link' => video_file.url)
    end
  end

end
