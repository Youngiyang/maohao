module V1
  class ShopsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'shops' do
      params do
        use :latlng, :pagenate
        requires :city_id, type: Integer
        optional :shop_class_id, type: Integer, default: 0
        optional :distance, type: Integer, default: 0
        optional :order, values: ['intelligence', 'star_grade', 'distance', 'created_at'], default: 'intelligence'
      end
      get '' do
        distance = params[:distance]
        order = params[:order]
        shop_class_id = params[:shop_class_id]
        point = "POINT(#{params[:lng]} #{params[:lat]})"
        resources = Shop.select("shops.*, st_distance(location::geography, '#{point}'::geography) as distance")
                        .includes(:active_coupons, :first_class, :second_class)
        resources = resources.where(city_id: params[:city_id])
        if shop_class_id != 0
          resources = resources.where('first_class_id = ? or second_class_id = ?', shop_class_id, shop_class_id)
        end
        if distance > 0
          resources = resources.where("st_dwithin(location::geography, '#{point}'::geography, #{distance})")
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

      params do
        requires :city_id, type: Integer
      end
      get 'hot_search_words' do
        hot_search_words = ['小面', '刘一手', '串串香', '鱼']
        return_hash = {}
        return_hash[:hot_words] = hot_search_words.map {|item| {word: item}}
        return_hash
      end

      params do
        requires :city_id, type: Integer
        requires :keyword
        use :latlng, :pagenate
      end
      get 'search' do
        point = "POINT(#{params[:lng]} #{params[:lat]})"
        shops = Shop.select("shops.*, st_distance(location::geography, '#{point}'::geography) as distance")
                    .where('city_id = ? and name ilike ?', params[:city_id], "%#{params[:keyword]}%" )
                    .offset(params[:offset])
                    .limit(params[:limit])
                    .includes(:active_coupons, :first_class, :second_class)
                    .order('distance')
        present shops, with: ShopListEntity
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

      params do
        requires :star, type: Integer, values: 1..5
        requires :content, type: String
        requires :coupon_item_id, type: Integer
      end
      post ':id/evaluate' do
        authenticate_by_token!
        coupon_item = CouponItem.find(params[:coupon_item_id])
        shop_evaluation = ShopEvaluation.find_by(coupon_item_id: params[:coupon_item_id])
        if (coupon_item.shop_id == params[:id].to_i && coupon_item.user_id == current_user.id &&
            coupon_item.state == 1 && !shop_evaluation.present?)
          evaluation = current_user.shop_evaluations.create!(
            shop_id: coupon_item.shop_id,
            user_nick_name: current_user.nick_name,
            star_grade: params[:star],
            content: params[:content],
            coupon_item_id: params[:coupon_item_id])
          shop = Shop.find(params[:id])
          total_star = shop.total_star + params[:star]
          evaluation_number = shop.evaluation_number + 1
          shop.update_attributes(
            total_star: total_star,
            evaluation_number: evaluation_number,
            star_grade: (total_star*1.0/evaluation_number).round(1)
          )
          evaluation
        else
          bad_request!('评论信息有误')
        end
      end
    end
  end
end
