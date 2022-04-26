require "test_helper"

module Superstore
  class CsvImporterTest < ActiveSupport::TestCase
    setup do
      @row = {
        "Row ID" => "1", "Order ID" => "3", "Order Date" => "10/13/2010", "Order Priority" => "Low",
        "Order Quantity" => "6", "Sales" => "261.54", "Discount" => "0.04", "Ship Mode" => "Regular Air",
        "Profit" => "-213.25", "Unit Price" => "38.94", "Shipping Cost" => "35", "Customer Name" => "Muhammed MacIntyre",
        "Province" => "Nunavut", "Region" => "Nunavut", "Customer Segment" => "Small Business", "Product Category" => "Office Supplies",
        "Product Sub-Category" => "Storage & Organization", "Product Name" => "Eldon Base for stackable storage shelf, platinum",
        "Product Container" => "Large Box", "Product Base Margin" => "0.8", "Ship Date" => "10/20/2010"
      }
      @importer = CsvImporter.allocate
      @importer.csv = [@row]
    end

    test "Creates one item" do
      assert_difference "LineItem.count", +1 do
        @importer.import!
      end
    end

    test "Parses dates correctly" do
      assert_equal Date.new(2020, 10, 13), @importer.parse_date("10/13/2020")
    end

    test "Gets attributtes from map" do
      map = { "Order ID" => :x_d }
      attrs = @importer.attributes_from(@row, map)
      assert_equal @row["Order ID"], attrs[:x_d]
      assert_equal 1, attrs.values.size
    end
  end
end
