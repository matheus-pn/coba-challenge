class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :customer
  belongs_to :shipment

  validates :quantity, :discount, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  monetize :sales_cents
  monetize :profit_cents
end
