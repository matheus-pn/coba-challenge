class Shipment < ApplicationRecord
  monetize :shipping_cost_cents

  enum shipment_mode: %i[delivery_truck  regular_air express_air]
  enum priority: %i[unspecified low medium high critical]
  validates :shipping_cost_cents, :priority, :shipment_mode, :province, :region, presence: true
  validates :shipping_cost_cents, numericality: { greater_than: 0 }
end
