class Shop < ActiveRecord::Base
  has_many :coupons
  belongs_to :first_class, class_name: 'ShopClass'
  belongs_to :second_class, class_name: 'ShopClass'
  belongs_to :city, class_name: 'Region'
  has_many :collections, as: :object
end
