require "csv"

module Superstore
  class CsvImporter
    CUSTOMER_MAPPING = {
      "Customer Name" => :name,
      "Customer Segment" => :segment
    }.freeze

    ORDER_MAPPING = {
      "Order ID" => :external_id,
      "Order Date" => :placement_date
    }.freeze

    PRODUCT_CATEGORY_MAPPING = {
      "Product Category" => :name
    }.freeze

    PRODUCT_SUBCATEGORY_MAPPING = {
      "Product Sub-Category" => :name
    }.freeze

    PRODUCT_MAPPING = {
      "Product Name" => :name,
      "Product Container" => :container,
      "Product Base Margin" => :base_margin
    }.freeze

    LINE_ITEM_MAPPING = {
      "Order Quantity" => :quantity,
      "Sales" => :sales_cents,
      "Discount" => :discount,
      "Profit" => :profit_cents,
    }.freeze

    SHIPMENT_MAPPING = {
      "Shipping Cost" => :shipping_cost_cents,
      "Ship Mode" => :shipment_mode,
      "Ship Date" => :shipment_date,
      "Province" => :province,
      "Region" => :region,
      "Order Priority" => :priority
    }.freeze

    SHIPMENT_MODE = {
      "Delivery Truck" => :delivery_truck,
      "Regular Air" => :regular_air,
      "Express Air" => :express_air
    }.freeze

    SHIPMENT_PRIORITY = {
      "Not Specified" => :unspecified,
      "Low" => :low,
      "Medium" => :medium,
      "High" => :high,
      "Critical" => :critical
    }.freeze

    attr_accessor :csv
    def initialize(filename)
      @csv = CSV.open(filename, headers: true).map(&:to_h)
    end

    def import!
      ApplicationRecord.transaction do
        @csv.each_with_index do |row, index|
          order = Order.find_or_initialize_by(
            order_attributes_from(row)
          )
          customer = Customer.find_or_initialize_by(
            attributes_from(row, CUSTOMER_MAPPING)
          )
          category = ProductCategory.find_or_initialize_by(
            attributes_from(row, PRODUCT_CATEGORY_MAPPING)
          )
          subcategory = ProductSubcategory.find_or_initialize_by(
            attributes_from(row, PRODUCT_SUBCATEGORY_MAPPING)
          )
          product = Product.find_or_initialize_by(
            attributes_from(row, PRODUCT_MAPPING, product_category: category, product_subcategory: subcategory)
          )
          shipment = Shipment.new(shipment_attributes_from(row))
          LineItem.create!(
            line_item_attributes_from(row, order: order, product: product, customer: customer, shipment: shipment)
          )
          print("Imported Item ##{index} / #{@csv.size}\r") unless Rails.env == "test"
        end
      end
    end

    def attributes_from(row, mapping, deps = {})
      attrs = row.slice(*mapping.keys)
      attrs = attrs.transform_keys { |key| mapping[key] }
      attrs.merge(deps)
    end

    def order_attributes_from(row, deps = {})
      attrs = attributes_from(row, ORDER_MAPPING, deps)
      attrs[:placement_date] = parse_date(attrs[:placement_date])
      attrs
    end

    def line_item_attributes_from(row, deps = {})
      attrs = attributes_from(row, LINE_ITEM_MAPPING, deps)
      attrs[:sales_cents] = Monetize.parse!(attrs[:sales_cents]).fractional
      attrs[:profit_cents] = Monetize.parse!(attrs[:profit_cents]).fractional
      attrs
    end

    def shipment_attributes_from(row, deps = {})
      attrs = attributes_from(row, SHIPMENT_MAPPING, deps)
      attrs[:shipping_cost_cents] = Monetize.parse!(attrs[:shipping_cost_cents]).fractional
      attrs[:shipment_mode] = SHIPMENT_MODE[attrs[:shipment_mode]]
      attrs[:priority] = SHIPMENT_PRIORITY[attrs[:priority]]
      attrs[:shipment_date] = parse_date(attrs[:shipment_date])
      attrs
    end

    def parse_date(date)
      Date.strptime(date, "%m/%d/%Y")
    end
  end
end
