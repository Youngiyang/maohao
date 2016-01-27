module V1
  class HomePageAPI < Grape::API
    helpers V1::SharedParams

    params do
      use :city_id
      use :latlng
    end
    get 'home_page' do
      app_banners = AppBanner.active
      recommended_shops = RecommendedShop.being_recommended.random_recommened
      nearby_shops = Shop.random_shops
                         .with_city_id(params['city_id'])
                         .limit(10)
                         .includes(:active_coupons, :first_class, :second_class)
      return_hash = {}
      return_hash['banners'] = AppBannerEntity.represent(app_banners, root: false)
      return_hash['recommended_shops'] = RecommendedShopEntity.represent(recommended_shops, root: false)
      return_hash['nearby_shops'] = ShopListEntity.represent(nearby_shops, root: false)
      return_hash
    end
  end
end
