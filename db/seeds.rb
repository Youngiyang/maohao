# users
user1 = User.create!(
  nick_name: "user1",
  avatar: "avatar_1",
  email: "user1@example.com",
  mobile: "13510116000",
  password: "123456",
  sex: "male",
  auth_token: "token1")

user2 = User.create!(
  nick_name: "user2",
  avatar: "avatar_2",
  email: "user2@example.com",
  mobile: "13510116111",
  password: "123456",
  sex: "female",
  auth_token: "token2")

# sellers
5.times do |n|
  User.create!(
    nick_name: "seller_#{n}",
    avatar: "seller_avatar_#{n}",
    email: "seller_#{n}@example.com",
    mobile: "1351011611#{n}",
    password: "123456",
    sex: "male",
    auth_token: "seller_token#{n}")
end



# shops
sellers = User.find_by(is_seller: true)
sellers.each do |seller|
  2.times do |n|
    shop = Shop.create!(
      first_class_id: n,
      name: seller.nick_name + "shop#{n}",
      logo: "logo",
      region_id: n,
      address: "address",
      location: "POINT(111 111)",
      telephone: "0755-27666782",
      business_hour_start: "09:00",
      business_hour_end: "22:00",
      user_id: seller.id,
      state: 1)
    5.times do |n|
      cc_types = [1, 2]
      Coupon.create!(
        shop_id: shop.id,
        name: "Coupon_#{n}",
        cc_type: cc_types[rand(2)],
        start_grab_time: Time.now - 2.days,
        end_grab_time: Time.now + 5.days,
        start_time: Time.now,
        end_time: Time.now + 20.days,
        cheap: 100,
        min_amount: 300,
        total: 100,
        giveout: 50,
        used: 10,
        state: 1)
    end
  end
end

5.times do |n|
  user1.coupon_items.create!(coupon_id: n + 3, coupon_sn: SecureRandom.uuid)
  user2.coupon_items.create!(coupon_id: n + 4, coupon_sn: SecureRandom.uuid)
end
