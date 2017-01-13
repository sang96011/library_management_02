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

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
