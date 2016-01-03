module V1
  class ShopClassesAPI < Grape::API
    namespace 'shop_classes' do
      get '' do
        shop_classes = ShopClass.where(parent_id: 0).includes(:sub_classes)
        present shop_classes, with: ShopClassListEntity
      end
    end
  end
end
