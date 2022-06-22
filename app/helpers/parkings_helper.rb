module ParkingsHelper
  def distance_kilometers(lat, lng, parking)
    DistanceService.distance_between([lat, lng], [parking.lat, parking.lng])
  end

  def walking_time_in_minutes(d)
    [(d * 11).round, 1].max
  end

  def pretty_price(price)
    return "" if price.blank?
    precision = price % 1 == 0 ? 0 : 2
    ActionController::Base.helpers.number_with_delimiter("%.#{precision}f" % price, locale: :en) + " €"
  end
end
