module V1
  class ShopsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'shops' do
      post ':id/follow' do
      end

      post ':id/unfollow' do
      end
    end
  end
end
