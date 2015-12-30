module V1
  class ShopsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'shops' do
      params do
        requires :lnt, type: Float
        requires :lng, type: Float
        requires :city_id, type: Integer
        optional :shop_class_id, type: Integer, default: 0
        optional :distance, type: Integer, default: 0
        optional :order, values: ['intelligence', 'star_grade', 'distance', 'create_at'], default: 'intelligence'
        optional :offset, type: Integer, default: 0
        optional :limit, type: Integer, default: 10
      end
      get '' do
        distance = params[:distance]
        order = params[:order]
        shop_class_id = params[:shop_class_id]
        lntlng = "POINT(#{params[:lnt]} #{params[:lng]})"
        resources = Shop.select("shops.*, st_distance(location, '#{lntlng}') as distance").includes(:active_coupons)
        resources = resources.where(city_id: params[:city_id])
        if shop_class_id != 0
          resources = resources.where('first_class_id = ? or second_class_id = ?', shop_class_id, shop_class_id)
        end
        if distance > 0
          responses = resources.where("st_dwithin(location, '#{lntlng}', #{distance})")
        end
        if order == 'intelligence'
          order = 'is_recommand DESC, distance ASC'
        elsif order != 'distance'
          order = "#{order} DESC"
        else
          order = "#{order} ASC"
        end
        resources = resources.order(order)
        present resources.offset(params[:offset]).limit(params[:limit]), with: ShopListEntity
      end

      get ':id' do
        shop = Shop.find(params[:id])
        present shop, with: ShopDetailWithCouponsEntity, user: current_user
      end

      post ':id/follow' do
        authenticate_by_token!
        shop = Shop.find(params[:id])
        if current_user.collections.exists?(object: shop)
          bad_request!('店铺已关注过')
        else
          current_user.collections.create!(object: shop)
          {message: '关注成功'}
        end
      end

      post ':id/unfollow' do
        authenticate_by_token!
        shop = Shop.find(params[:id])
        if current_user.collections.exists?(object: shop)
          current_user.collections.find_by(object: shop).destroy
          {message: '取消关注成功'}
        else
          bad_request!('店铺未关注过')
        end
      end
    end
  end
end
