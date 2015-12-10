class ShopClass < ActiveRecord::Base
  has_many :shops, dependent: :restrict_with_error
  has_many :sub_classes, class_name: 'ShopClass'
  belongs_to :parent_class, class_name: 'ShopClass'
end
