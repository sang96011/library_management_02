class Author < ApplicationRecord
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :follower_users, through: :followed, source: :follower,
    source_type: User.name, dependent: :destroy
  has_many :books, through: :follower, source: :followed,
    source_type: Book.name, dependent: :destroy
end
