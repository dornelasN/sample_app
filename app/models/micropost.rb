class Micropost < ApplicationRecord
  belongs_to :user
  # validate the presence of user_id in a micropost
  validates :user_id, presence: true
  # validates the presence of content attribute in micropost, and its maximum length of 140 chars
  validates :content, presence: true, length: { maximum: 140 }
end
