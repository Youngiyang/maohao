class ShopClass < ActiveRecord::Base
  has_many :shops, dependent: :restrict_with_error
  has_many :sub_classes, class_name: 'ShopClass', foreign_key: :parent_id
  belongs_to :parent_class, class_name: 'ShopClass', foreign_key: :parent_id
end
