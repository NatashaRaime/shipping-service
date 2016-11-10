# require_relative 'package'
class Shipment #< ActiveRecord::Base
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

  def ups(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: UPSLOGIN, password: UPS_PASSWORD, key: UPS_KEY)
    response = ups.find_rates(origin, destination, packages)
    return response
  end

  def usps(origin, destination, packages)
    usps = ActiveShipping::UPS.new(login: USPSLOGIN)
    response = usps.find_rates(origin, destination, packages)
    return response
  end


end
