class RecommendedShopEntity < BaseEntity
  expose :shop_id
  expose_qiniu_url :image, as: :show_image
end
