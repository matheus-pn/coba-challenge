class Customer < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :name, :segment, presence: true
end
