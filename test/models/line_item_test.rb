require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "valid item" do
    item = line_items(:one)
    assert item.valid?
  end

  test "invalid item" do
    item = line_items(:one)
    item.quantity = 0
    assert_not item.valid?
  end
end
