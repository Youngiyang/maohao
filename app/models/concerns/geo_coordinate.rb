module Concerns
  module GeoCoordinate
    def lnt
      location.x
    end

    def lnt=(x)
      location.x = x
    end

    def lng
      location.y
    end

    def lng=(y)
      location.y
    end
  end
end
