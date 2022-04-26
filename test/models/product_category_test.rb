require "test_helper"

class ProductCategoryTest < ActiveSupport::TestCase
  test "valid product category" do
    cat = product_categories(:one)
    assert cat.valid?
  end

  test "invalid product category" do
    cat = product_categories(:one)
    cat.name = ""
    assert_not cat.valid?
  end
end
