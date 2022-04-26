require "test_helper"

class ShipmentTest < ActiveSupport::TestCase
  test "valid shipment" do
    shipm = shipments(:one)
    assert shipm.valid?
  end

  test "invalid shipment" do
    shipm = shipments(:one)
    shipm.province = ""
    assert_not shipm.valid?
  end
end
