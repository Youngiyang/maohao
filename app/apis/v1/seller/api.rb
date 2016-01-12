module V1
  module Seller
    class API < Grape::API
      mount V1::Seller::SessionsAPI
      mount V1::Seller::SellersAPI
    end
  end
end
