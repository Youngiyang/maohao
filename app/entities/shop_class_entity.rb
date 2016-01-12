class ShopClassEntity < BaseEntity
  expose :id, :name
  expose_qiniu_url :icon
end
