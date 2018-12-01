class Product < ApplicationRecord
  belongs_to :category
  has_many :ranks, dependent: :destroy

  validates :asin, presence: true
end
