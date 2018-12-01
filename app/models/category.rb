class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category"
  has_many :children, class_name: "Category", foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :nullify

  validates :name, presence: true
end