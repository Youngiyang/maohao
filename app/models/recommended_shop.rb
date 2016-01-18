class RecommendedShop < ActiveRecord::Base
  scope :being_recommended, ->{where(state: 1)}

  def self.random_recommened limit=2
    self.select('*, random() as rnd').order('rnd').limit(limit)
  end
end
