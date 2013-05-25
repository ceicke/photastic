class Comment < ActiveRecord::Base
  attr_accessible :nickname, :picture_id, :user_id, :comment

  validates :picture_id, presence: true
  validates :comment, presence: true
  before_validation :user_id_or_nickname

  belongs_to :picture
  belongs_to :user

  def author
    if user_id.blank?
      nickname
    else
      if user.name.blank?
        user.email
      else
        user.name
      end
    end
  end

  private
  def user_id_or_nickname
    errors.add(:base, I18n.t('user_or_nickname_missing')) and return false if user_id.blank? && nickname.blank?
  end
end
