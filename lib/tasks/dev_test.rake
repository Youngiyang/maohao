namespace :dev_test do
  desc "add test datas"
  task :test_datas => [:environment, 'init:shop_classes', 'init:regions'] do
    if !User.exists?(mobile: "13011024902")

      liujun = User.create!(
        mobile: '13011024902',
        password: '123456'
      )
      shop_classes = ShopClass.where('parent_id != 0')
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

        shop_class = shop_classes.sample(1)[0]
        shop = Shop.create!(
          first_class_id: shop_class.parent_id,
          second_class_id: shop_class.id,
          name: Faker::Company.name[0...16],
          region_id: 1,
          logo: "FuVvGY489Ma_AMWgdPVWm4PBXAlC",
          images: ["Fmw6PlH0yuLssDYULWY3oOE73p1t"],
          address: Faker::Address.street_address,
          location: "POINT(#{random(113460000..114370000)/1000000.0} #{rand(22270000..22520000)/1000000.0})",
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
            start_time: Time.now(),
            end_time: rand(10..100).days.since,
            total: rand(200..300),
            state: 1,
            image: "FiBwr3Yo9-wODa6bxQVbTBI2qy-P"
          )
        end
      end

      10.times do |n|
        coupon = Coupon.find(n + 3)
        state = rand(2)
        if state == 1
          used_at = Time.now - 1.days
        else
          used_at = nil
        end
        CouponItem.create!(
          user_id: liujun.id,
          coupon_id: coupon.id,
          coupon_sn: SecureRandom.uuid,
          state: state,
          used_at: used_at,
          expired_at: Time.now + 5.days,
          shop_id: coupon.shop_id,
          shop_name: coupon.shop.name,
          coupon_name: coupon.name,
          coupon_type: coupon.cc_type,
          coupon_cheap: coupon.cheap,
          coupon_discount: coupon.discount,
          coupon_start_time: coupon.start_time,
          coupon_end_time: coupon.end_time,
          coupon_min_amount: coupon.min_amount,
          coupon_image: "FiBwr3Yo9-wODa6bxQVbTBI2qy-P")
      end

      5.times do
        liujun.collections.create!(object: Shop.offset(rand(1..100)).limit(1)[0])
      end
    end
  end
end
