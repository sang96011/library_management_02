class Publisher < ApplicationRecord
  has_many :books, through: :follows, dependent: :destroy
end
