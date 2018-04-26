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

  after_save :coconut_encode

  def coconut_encode

    coconut_job = Coconut::Job.create(
      :api_key => ENV['COCONUT_API_KEY'],
      :source => "http://photasti.cc/#{video_file.url}",
      :webhook => "http://photasti.cc/video_callback/callback?video_id=#{id}",
      :outputs => prepare_coconut_configuration
    )

    if coconut_job['status'] == 'ok'
      logger.debug "Video File ID #{self.id}: coconut job submitted successfully"
      return coconut_job
    else
      self.video.coconut_error!
      logger.info "Video File ID #{self.id}: error submitting job to coconut #{coconut_job['error_code']} #{coconut_job['error_message']}"
      raise 'Coconut submit failed'
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

  private
  def prepare_coconut_configuration
    username = ENV['SERVER_USERNAME']
    password = ENV['SERVER_PASSWORD']

    target_dir = '/home/photastic/app/shared/public/system/videos_encoded'

    FileUtils.mkdir_p "#{target_dir}/#{album.id}/#{id}"

    conf = ""

    conf << "var username = #{username}"
    conf << "\n"
    conf << "var password = #{password}"
    conf << "\n"
    conf << "var host = photasti.cc"
    conf << "\n"
    conf << "var cdn = sftp://$username:$password@$host"
    conf << "\n"

    # Settings
    conf << "set source = http://photasti.cc/#{video_file.url}"
    conf << "\n"
    conf << "set webhook = http://photasti.cc/video_callback/callback?video_id=#{id}"
    conf << "\n"

    # Outputs
    conf << "-> mp4:720p = $cdn/#{target_dir}/#{album.id}/#{id}/ios.mp4"
        conf << "\n"
    conf << "-> jpg:250x = $cdn/#{target_dir}/#{album.id}/#{id}/thumb.jpg, number=1"
    conf << "\n"
  end

end
