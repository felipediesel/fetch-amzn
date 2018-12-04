class Rank < ApplicationRecord
  belongs_to :product
  belongs_to :category

  validates :position, numericality: { only_integer: true, greater_than: 0 }

  def categories
    category.tree
  end
end
