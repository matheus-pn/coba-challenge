class Order < ApplicationRecord
  has_many :line_items
  has_many :customers, through: :line_items

  validates :external_id, uniqueness: true
  validates :external_id, presence: true
end
