require "test_helper"

class ProductSubcategoryTest < ActiveSupport::TestCase
  test "valid product sub category" do
    subcat = product_subcategories(:one)
    assert subcat.valid?
  end

  test "invalid product sub category" do
    subcat = product_subcategories(:one)
    subcat.name = ""
    assert_not subcat.valid?
  end
end
