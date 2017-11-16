class Micropost < ApplicationRecord
  belongs_to :user
  # default_scope order(created_at: :desc) let the microposts be order by descending order of creation
  default_scope -> { order(created_at: :desc) }
  # Associate uploaded image with model using mount_uploader
  # args: symbol representing the attribute (:picture), and class name of the generated uploader
  mount_uploader :picture, PictureUploader
  # validate the presence of user_id in a micropost
  validates :user_id, presence: true
  # validates the presence of content attribute in micropost, and its maximum length of 140 chars
  validates :content, presence: true, length: { maximum: 140 }
end
