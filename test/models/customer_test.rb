require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "valid customer" do
    customer = customers(:one)
    assert customer.valid?
  end

  test "invalid customer" do
    customer = customers(:one)
    customer.segment = ""
    assert_not customer.valid?
  end
end
