class Book < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :follows, as: :follower
  has_many :authors, through: :follows, source: :follower, source_type: "Author"
  has_many :categories, through: :book_categories, foreign_key: :book_id

  belongs_to :publisher
end
