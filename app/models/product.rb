class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :ranks, dependent: :destroy

  validates :asin, presence: true

  def categories
    if category
      category.tree
    else
      []
    end
  end
end
