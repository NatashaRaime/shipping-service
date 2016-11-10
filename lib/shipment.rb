# require_relative 'package'
class Shipment #< ActiveRecord::Base
  attr_reader :origin, :destination, :packages
  #activemerchant::shipping
  # include ActiveShipping::Shipping

    USPSLOGIN = ENV["USPS_LOGIN"]
    UPSLOGIN = ENV["UPS_LOGIN"]
    UPS_KEY = ENV["UPS_KEY"]
    UPS_PASSWORD = ENV["UPS_PASSWORD"]
    UPS_ORIGIN_ACCOUNT = ENV["UPS_ORIGIN_ACCOUNT"]
    UPS_ORIGIN_NAME = ENV["UPS_ORIGIN_NAME"]


  def initialize(origin, destination, packages)
    @origin = origins(origin["country"], origin[:state], origin[:city], origin[:zip])
    @destination = destinations(destination[:country], destination[:state], destination[:city], destination[:zip])
    @packages = package(packages[:weight], packages[:dimensions][0], packages[:dimensions][1], packages[:dimensions][2])
  end

  def package(weight, length, width, height)
    package = ActiveShipping::Package.new(weight.to_i * 16,[length.to_i, width.to_i, height.to_i], units: :imperial)
    return package
  end

  def origins(country, state, city, zip)
    origin = ActiveShipping::Location.new(country: country, state: state, city: city, zip: zip)
    return origin
  end

  def destinations(country, state, city, zip)
    destination = ActiveShipping::Location.new(country: country, state: state, city: city, zip: zip)
    return destination
  end

  def self.ups(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: "shopifolk", password: "Shopify_rocks", key: "7CE85DED4C9D07AB")
    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    return ups_rates
  end

  def self.usps(origin, destination, packages)
    usps = ActiveShipping::USPS.new(login: "677JADED7283")
    response = usps.find_rates(origin, destination, packages)
    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    return usps_rates
  end


end
