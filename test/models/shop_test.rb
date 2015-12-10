require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @shop = Shop.new(
      first_class_id: 1,
      name: "name",
      region_id: 1,
      address: "address",
      location: "POINT(111 111)",
      telephone: "13510116000",
      business_hour_start: DateTime.now,
      business_hour_end: DateTime.now,
      user_id: 1,
      state: 1)
    # puts ">>>>>>>>>>>>>>>" + @shop.to_s + "<<<<<<<<<<<<<<<"
  end

  test "valid telephone" do
    # puts @shop.as_json
    valid_tels = %w[13510116000 15989426000 27666890 2755-23456789-123 010-25904322 0755-27666782]
    valid_tels.each do |valid_tel|
      @shop.telephone = valid_tel
      assert @shop.valid?, "#{valid_tel} should be valid"
      assert @shop.save
    end
  end
end
