# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
liujun = User.create!(
  mobile: '13011024902',
  password: '123456'
)

# 商家
100.times do |n|
  seller = User.create!(
    mobile: "136510249#{n.to_s.rjust(2, '0')}",
    password: '123456',
    is_seller: true,
    real_name: Faker::Name.name,
    identify_sn: Faker::Number.number(18),
    verfied_at: Time.now
  )

  shop = Shop.create!(
    first_class_id: 1,
    second_class_id: 1,
    name: Faker::Company.name[0...16],
    region_id: 1,
    logo: "shop-logo-#{n}.png",
    images: ["images-#{n}.jpg"],
    address: Faker::Address.street_address,
    location: "POINT(#{Faker::Address.latitude} #{Faker::Address.longitude})",
    telephone: seller.mobile,
    star_grade: (rand(10..50)/10.0).round(1),
    business_on_holiday: rand(1..100) < 90,
    business_hour_start: '08:00',
    business_hour_end: '23:00',
    is_recommand: rand(1..10) > 8,
    state: 1,
    description: Faker::Lorem.paragraph[0...200],
    notice: Faker::Lorem.paragraph[0...200],
    user_id: seller.id
  )
  2.times do |n|
    cc_type = n % 2 + 1
    cheap, discount = nil;
    if cc_type == 1
      min_amount = 100
      cheap = rand(10..20)
      name = "满#{min_amount}减#{cheap}"
    else
      min_amount = 150
      discount = (rand(50..90)/10.0).round(1)
      name = "满#{min_amount}打#{discount}折"
    end
    shop.coupons.create!(
      name: name,
      cc_type: cc_type,
      cheap: cheap,
      discount: discount,
      min_amount: min_amount,
      start_grab_time: Time.now(),
      end_grab_time: rand(10..100).days.since,
      period_time: rand(3..7),
      total: rand(200..300),
      state: 1
    )
  end
end
