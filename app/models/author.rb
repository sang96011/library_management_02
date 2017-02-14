class Author < ApplicationRecord
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :followed_users, through: :relationship, source: :followed,
    source_type: User.name, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, foreign_key: :author_id
end
