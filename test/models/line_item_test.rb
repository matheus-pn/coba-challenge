require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "valid item" do
    item = line_items(:one)
    assert item.valid?
  end

  test "invalid item" do
    [
      [:discount, 2],
      [:discount, -1],
      [:sales,  -2]
    ].each do |field, value|
      item = line_items(:one)
      item.send("#{field}=", value)
      assert_not item.valid?
    end
  end
end
