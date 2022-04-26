require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "valid order" do
    order = orders(:one)
    assert order.valid?
  end

  test "invalid order" do
    order = orders(:one)
    order2 = order.dup
    assert_not order2.valid?
  end
end
