require 'test_helper'

class TownTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "town not exists" do
    VCR.use_cassette("town_not_exists") do
      unknown = Town.new
      unknown.name = 'MyString'
      assert !unknown.valid?
    end
  end

  test "town validation does geocoding"  do
    VCR.use_cassette("town_validation_geocoding") do
      belfort = Town.new
      belfort.name = 'belfort'
      belfort.postal_code = '90000'
      assert belfort.valid?
      assert_equal(47.6379599, belfort.lat)
      assert_equal(6.8628942, belfort.long)
    end
  end
end
