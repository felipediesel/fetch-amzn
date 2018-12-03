class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :nullify

  validates :name, presence: true

  def self.create_from_list(names, parent = nil)
    names.inject([]) do |categories, name|
      categories.push(self.find_or_create_by!(name: name, parent: categories.last))
    end
  end
end
