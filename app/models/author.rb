class Author < ApplicationRecord
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :follower_users, through: :followed, source: :follower,
    source_type: User.name, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, foreign_key: :author_id
  scope :search_data, ->data {where "name LIKE '%#{data[:value]}%'"}

  class << self
    def search data
      self.search_data data
    end
  end
end
