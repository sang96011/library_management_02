class Book < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :authors, through: :followed, source: :follower,
    source_type: Author.name
  has_many :categories, through: :book_categories, foreign_key: :book_id
  has_many :users_like, through: :followed, source: :follower,
    source_type: User.name
  belongs_to :publisher
end
