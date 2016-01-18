class AppBanner < ActiveRecord::Base
  scope :active, ->{where(state: 1)}
end
