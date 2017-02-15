class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :follower, as: :follower, class_name: Relationship.name
  has_many :followed, as: :followed, class_name: Relationship.name
  has_many :follower_authors, through: :follower, source: :followed,
    source_type: Author.name, dependent: :destroy
  has_many :follower_books, through: :follower, source: :followed,
    source_type: Book.name, dependent: :destroy
  has_many :follower_users, through: :follower, source: :follower,
    source_type: User.name, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :orders, dependent: :destroy

  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  scope :search_data, -> data {where "#{data[:attribute]} LIKE '%#{data[:value]}%'"}

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def search data
      self.search_data data
    end

    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |user|
          csv << user.attributes.values_at(*column_names)
        end
      end
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    self == user
  end

  def like_book book
    follower_books << book
  end

  def unlike_book book
    follower_books.delete book
  end

  def follow_author author
    follower_authors << author
  end

  def unfollow_author author
    follower_authors.delete author
  end

  private
  def downcase_email
    email.downcase!
  end
end
