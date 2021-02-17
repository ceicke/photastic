class Comment < ActiveRecord::Base
  validates :comment, presence: true
  validates :commentable_id, presence: true

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
end
