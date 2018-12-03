class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :ranks, dependent: :destroy

  validates :asin, presence: true
end
