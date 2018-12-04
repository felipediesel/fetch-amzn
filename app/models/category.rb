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

  # TODO: This methods performs badly and
  # the whole tree should be stored on a field of the category table
  def tree
    if parent
      [parent.tree, self].flatten
    else
      [self]
    end
  end
end
