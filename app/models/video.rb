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

  has_attached_file :video_file

  after_save :heywatch_encode

  def heywatch_encode
    username = ENV['SERVER_USERNAME']
    password = ENV['SERVER_PASSWORD']
    heywatch_api_key = ENV['HEYWATCH_API_KEY']

    target_dir = '/home/photastic/app/shared/public/system/videos_encoded'

    FileUtils.mkdir_p "#{target_dir}/#{album.id}/#{id}"

    conf = ""

    conf << "set source = http://photasti.cc/#{video_file.url}"
    conf << "\n"
    conf << "set webhook = http://photasti.cc/video_callback/callback?video_id=#{id}"
    conf << "\n"
    conf << "-> mp4_720p = sftp://#{username}:#{password}@photasti.cc:22#{target_dir}/#{album.id}/#{id}/ios.mp4"
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

end
