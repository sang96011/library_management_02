class Author < ApplicationRecord
  has_many :follows, as: :followed
  has_many :followed_users, through: :follows, source: :followed,
    source_type: "User", dependent: :destroy
  has_many :books, through: :follows, source: :followed,
    source_type: "Book", dependent: :destroy
end
