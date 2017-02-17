class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}

  scope :search_data, ->data {where "name LIKE '%#{data[:value]}%'"}

  class << self
    def search data
      self.search_data data
    end

    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |publisher|
          csv << publisher.attributes.values_at(*column_names)
        end
      end
    end
  end
end
