# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 商铺分类
shop_classes = [
      {id: 1, parent_id: 0, name: "爱车"},
      {id: 2, parent_id: 1, name: "4S店/汽车销售"},
      {id: 3, parent_id: 1, name: "加油站 "},
      {id: 4, parent_id: 1, name: "驾校"},
      {id: 5, parent_id: 1, name: "配件/车饰"},
      {id: 6, parent_id: 1, name: "汽车保险"},
      {id: 7, parent_id: 1, name: "汽车美容"},
      {id: 8, parent_id: 1, name: "汽车租赁"},
      {id: 9, parent_id: 1, name: "停车场"},
      {id: 10, parent_id: 1, name: "维修保养"},
      {id: 11, parent_id: 1, name: "洗车"},
      {id: 12, parent_id: 1, name: "更多汽车服务"},
      {id: 13, parent_id: 0, name: "购物"},
      {id: 14, parent_id: 13, name: "办公/文化用品"},
      {id: 15, parent_id: 13, name: "超市/便利店"},
      {id: 16, parent_id: 13, name: "服饰鞋包"},
      {id: 17, parent_id: 13, name: "花店"},
      {id: 18, parent_id: 13, name: "化妆品"},
      {id: 19, parent_id: 13, name: "家居建材"},
      {id: 20, parent_id: 13, name: "家装"},
      {id: 21, parent_id: 13, name: "食品茶酒"},
      {id: 22, parent_id: 13, name: "书店"},
      {id: 23, parent_id: 13, name: "数码产品"},
      {id: 24, parent_id: 13, name: "眼镜店"},
      {id: 25, parent_id: 13, name: "药店"},
      {id: 26, parent_id: 13, name: "运动户外"},
      {id: 27, parent_id: 13, name: "珠宝饰品"},
      {id: 28, parent_id: 13, name: "更多购物场所"},
      {id: 29, parent_id: 0, name: "家装"},
      {id: 30, parent_id: 29, name: "厨房卫浴"},
      {id: 31, parent_id: 29, name: "家具家居"},
      {id: 32, parent_id: 29, name: "家用电器"},
      {id: 33, parent_id: 29, name: "建材"},
      {id: 34, parent_id: 29, name: "装修设计"},
      {id: 35, parent_id: 0, name: "教育培训"},
      {id: 36, parent_id: 35, name: "美术"},
      {id: 37, parent_id: 35, name: "教育院校"},
      {id: 38, parent_id: 35, name: "体育"},
      {id: 39, parent_id: 35, name: "外语"},
      {id: 40, parent_id: 35, name: "音乐"},
      {id: 41, parent_id: 35, name: "职业技术"},
      {id: 42, parent_id: 35, name: "更多教育培训"},
      {id: 43, parent_id: 0, name: "结婚"},
      {id: 44, parent_id: 43, name: "个性写真"},
      {id: 45, parent_id: 43, name: "婚戒首饰"},
      {id: 46, parent_id: 43, name: "婚庆公司"},
      {id: 47, parent_id: 43, name: "婚纱摄影"},
      {id: 48, parent_id: 0, name: "景点"},
      {id: 49, parent_id: 48, name: "采摘/农家乐"},
      {id: 50, parent_id: 48, name: "动植物园"},
      {id: 51, parent_id: 48, name: "公园"},
      {id: 52, parent_id: 48, name: "景点/郊游"},
      {id: 53, parent_id: 48, name: "漂流"},
      {id: 54, parent_id: 48, name: "温泉"},
      {id: 55, parent_id: 48, name: "游乐场"},
      {id: 56, parent_id: 0, name: "酒店"},
      {id: 57, parent_id: 56, name: "度假村"},
      {id: 58, parent_id: 56, name: "公寓式酒店"},
      {id: 59, parent_id: 56, name: "经济型酒店"},
      {id: 60, parent_id: 56, name: "精品酒店"},
      {id: 61, parent_id: 56, name: "客栈旅舍"},
      {id: 62, parent_id: 56, name: "青年旅舍"},
      {id: 63, parent_id: 56, name: "三星级酒店"},
      {id: 64, parent_id: 56, name: "四星级酒店"},
      {id: 65, parent_id: 56, name: "五星级酒店"},
      {id: 66, parent_id: 56, name: "更多酒店住宿"},
      {id: 67, parent_id: 0, name: "俪人"},
      {id: 68, parent_id: 67, name: "齿科"},
      {id: 69, parent_id: 67, name: "美发"},
      {id: 70, parent_id: 67, name: "美甲"},
      {id: 71, parent_id: 67, name: "美容/SPA"},
      {id: 72, parent_id: 67, name: "瘦身纤体"},
      {id: 73, parent_id: 67, name: "舞蹈"},
      {id: 74, parent_id: 67, name: "瑜伽"},
      {id: 75, parent_id: 0, name: "美食"},
      {id: 76, parent_id: 75, name: "茶馆"},
      {id: 77, parent_id: 75, name: "川菜"},
      {id: 78, parent_id: 75, name: "东南亚菜"},
      {id: 79, parent_id: 75, name: "海鲜"},
      {id: 80, parent_id: 75, name: "韩国料理"},
      {id: 81, parent_id: 75, name: "火锅"},
      {id: 82, parent_id: 75, name: "咖啡厅"},
      {id: 83, parent_id: 75, name: "面包甜点"},
      {id: 84, parent_id: 75, name: "日本料理"},
      {id: 85, parent_id: 75, name: "烧烤"},
      {id: 86, parent_id: 75, name: "西餐"},
      {id: 87, parent_id: 75, name: "小吃快餐"},
      {id: 88, parent_id: 75, name: "粤菜"},
      {id: 89, parent_id: 75, name: "自助餐"},
      {id: 90, parent_id: 75, name: "其他"},
      {id: 91, parent_id: 0, name: "亲子"},
      {id: 92, parent_id: 91, name: "亲子购物"},
      {id: 93, parent_id: 91, name: "亲子摄影"},
      {id: 94, parent_id: 91, name: "亲子游乐"},
      {id: 95, parent_id: 91, name: "幼儿教育"},
      {id: 96, parent_id: 91, name: "孕产护理"},
      {id: 97, parent_id: 0, name: "生活服务"},
      {id: 98, parent_id: 97, name: "宠物"},
      {id: 99, parent_id: 97, name: "电信营业厅"},
      {id: 100, parent_id: 97, name: "房屋地产"},
      {id: 101, parent_id: 97, name: "公司企业"},
      {id: 102, parent_id: 97, name: "家政"},
      {id: 103, parent_id: 97, name: "交通"},
      {id: 104, parent_id: 97, name: "居家维修"},
      {id: 105, parent_id: 97, name: "快照/冲印"},
      {id: 106, parent_id: 97, name: "旅行社"},
      {id: 107, parent_id: 97, name: "售票点"},
      {id: 108, parent_id: 97, name: "物流快递"},
      {id: 109, parent_id: 97, name: "洗衣店"},
      {id: 110, parent_id: 97, name: "小区/商务楼"},
      {id: 111, parent_id: 97, name: "医院"},
      {id: 112, parent_id: 97, name: "银行"},
      {id: 113, parent_id: 97, name: "更多生活服务"},
      {id: 114, parent_id: 0, name: "休闲娱乐"},
      {id: 115, parent_id: 114, name: "KTV"},
      {id: 116, parent_id: 114, name: "文化艺术"},
      {id: 117, parent_id: 114, name: "密室"},
      {id: 118, parent_id: 114, name: "棋牌室"},
      {id: 119, parent_id: 114, name: "网吧网咖"},
      {id: 120, parent_id: 114, name: "洗浴"},
      {id: 121, parent_id: 114, name: "游乐游艺"},
      {id: 122, parent_id: 114, name: "电影院"},
      {id: 123, parent_id: 114, name: "真人CS"},
      {id: 124, parent_id: 114, name: "足疗按摩"},
      {id: 125, parent_id: 114, name: "更多休闲娱乐"},
      {id: 126, parent_id: 0, name: "运动健身"},
      {id: 127, parent_id: 126, name: "保龄球馆"},
      {id: 128, parent_id: 126, name: "健身中心"},
      {id: 129, parent_id: 126, name: "篮球场"},
      {id: 130, parent_id: 126, name: "台球馆"},
      {id: 131, parent_id: 126, name: "体育场馆"},
      {id: 132, parent_id: 126, name: "羽毛球馆"},
      {id: 133, parent_id: 126, name: "更多运动场馆"}]
if !ShopClass.exists?(name: shop_classes[0][:name], parent_id: shop_classes[0][:parent_id])
  shop_classes.each do |shop_class|
    ShopClass.create!(shop_class)
  end
  ActiveRecord::Base.connection.exec_query("select setval('shop_classes_id_seq',(select max(id) from shop_classes))")
end

if !User.exists?(mobile: "13011024902")

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

  10.times do |n|
    coupon = Coupon.find(n + 2)
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
      coupon_start_time: Time.now,
      coupon_end_time: Time.now + coupon.period_time.days,
      coupon_min_amount: coupon.min_amount)
  end

  5.times do
    liujun.collections.create!(object: Shop.offset(rand(1..100)).limit(1)[0])
  end
end
