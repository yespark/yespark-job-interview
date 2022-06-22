# frozen_string_literal: true

class DistanceService
  # Conversion factor: multiply by kilometers to get miles.
  KM_IN_MI = 0.621371192
  # Conversion factor: multiply by nautical miles to get miles.
  KM_IN_NM = 0.539957
  # Conversion factor: multiply by radians to get degrees.

  # Distance between two points on Earth (Haversine formula)
  # The options hash supports: { :units :mi or :km } ( Default is km )
  def self.distance_between(point1, point2, options = {})
    # set default options
    options[:units] ||= :km
    # convert degrees to radians
    point1 = to_radians(point1)
    point2 = to_radians(point2)
    # compute deltas
    dlat = point2[0] - point1[0]
    dlon = point2[1] - point1[1]

    a = Math.sin(dlat / 2)**2 + Math.cos(point1[0]) *
      Math.sin(dlon / 2)**2 * Math.cos(point2[0])
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    c * earth_radius(options[:units])
  end

  def self.to_radians(*args)
    args = args.first if args.first.is_a?(Array)
    if args.size == 1
      args.first * (Math::PI / 180)
    else
      args.map { |i| to_radians(i) }
    end
  end

  def self.earth_radius(units)
    units ||= :km
    case units
      when :km then EARTH_RADIUS
      when :mi then to_miles(EARTH_RADIUS)
      when :nm then to_nautical_miles(EARTH_RADIUS)
    end
  end

  EARTH_RADIUS = 6371.0

  # Convert miles to kilometers.
  def self.to_kilometers(mi)
    mi * mi_in_km
  end

  # Convert kilometers to miles.
  def self.to_miles(km)
    km * km_in_mi
  end

  # Convert kilometers to nautical miles.
  def self.to_nautical_miles(km)
    km * km_in_nm
  end

  # Conversion factor: km to mi.
  def self.km_in_mi
    KM_IN_MI
  end

  # Conversion factor: km to nm.
  def self.km_in_nm
    KM_IN_NM
  end
end
