module Concerns
  module GeoCoordinate
    def lnt
      location.y
    end

    def lnt=(y)
      location.y = y
    end

    def lng
      location.x
    end

    def lng=(x)
      location.x = x
    end
  end
end
