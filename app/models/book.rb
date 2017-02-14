class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, foreign_key: :book_id
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories, foreign_key: :book_id
  has_many :users_like, through: :followed, source: :follower,
    source_type: User.name
  belongs_to :publisher
  validates :title, presence: true, length: {maximum: 250}
  validates :pages, presence: true, length: {maximum: 6},
    numericality: {only_integer: true}
  validates :price, presence: true, length: {maximum: 9},
    numericality: {only_integer: true}
  validates :quantity, presence: true, length: {maximum: 4},
    numericality: {only_integer: true}
  validates :publish_date, presence: true
end
