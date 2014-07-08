class Comment < ActiveRecord::Base
  validates :comment, presence: true
  before_validation :user_id_or_nickname

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  def author
    if user_id.blank?
      nickname
    else
      if user.nickname.blank?
        user.email
      else
        user.nickname
      end
    end
  end

  private
  def user_id_or_nickname
    errors.add(:base, I18n.t('user_or_nickname_missing')) and return false if user_id.blank? && nickname.blank?
  end
end
