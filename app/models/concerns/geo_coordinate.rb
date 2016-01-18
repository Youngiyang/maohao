module Concerns
  module GeoCoordinate
    def lat
      location.y
    end

    def lat=(y)
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
