class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :follows, as: :follower
  has_many :follows, as: :followed
  has_many :follower_authors, through: :follows, source: :follower,
    source_type: "Author", dependent: :destroy
  has_many :follower_books, through: :follows, source: :follower,
    source_type: "Book", dependent: :destroy
  has_many :follower_users, through: :follows, source: :follower,
    source_type: "User", dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :orders, dependent: :destroy
end
