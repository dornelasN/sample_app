class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  # active_relationship.follower : returns the follower
  # active_relationship.following: returns the followed user
  # user.active_relationships.create(followed_id: other_user.id): creates an active relationship
  #associated with user
  # user.active_relationships.create!(followed_id: other_user.id): creates an active relationship
  #associated with user (exception on failure)
  # user.active_relationships.build(followed_id: other_user.id): returns a new Relationship object
  #associated with user
end
