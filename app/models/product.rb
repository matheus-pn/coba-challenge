class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :product_subcategory
  validates :name, :container, presence: true
end
