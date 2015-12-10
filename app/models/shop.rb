class Shop < ActiveRecord::Base
  has_many :coupons
  belongs_to :first_class, class_name: 'ShopClass'
  belongs_to :second_class, class_name: 'ShopClass'
  belongs_to :city, class_name: 'Region'
  belongs_to :user
  has_many :collections, as: :object

  validates :name, presence: true, length: 1..16
  validates :address, presence: true, length: 1..50
  VALID_TEL_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}|(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?\z/
  validates :telephone, presence: true, format: { with: VALID_TEL_REGEX }
  validates :description, length: { maximum: 200 }
  validates :notice, length: { maximum: 200 }
  validates :audit_reason, length: { maximum: 200 }
end
