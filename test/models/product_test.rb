require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "valid product" do
    product = products(:one)
    assert product.valid?
  end

  test "invalid product" do
    product = products(:one)
    product.name = ""
    assert_not product.valid?
  end
end
