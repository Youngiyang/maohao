class ShopClassListEntity < ShopClassEntity
  root 'shop_classes'
  expose :sub_classes, using: ShopClassEntity
end
