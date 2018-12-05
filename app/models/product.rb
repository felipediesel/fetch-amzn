class Product < ApplicationRecord
  STATES = %w(progress ready)

  belongs_to :category, optional: true
  has_many :ranks, dependent: :destroy

  validates :asin, presence: true
  validates :state, :inclusion => { :in => STATES }

  def categories
    if category
      category.tree
    else
      []
    end
  end
end
