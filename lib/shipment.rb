require_relative 'package'
class Shipment < ActiveRecord::Base
  #activemerchant::shipping
  include ActiveShipping::Shipping

    USPSLOGIN = ENV["USPS_LOGIN"]
    UPSLOGIN = ENV["UPS_LOGIN"]
    UPS_KEY = ENV["UPS_KEY"]
    UPS_PASSWORD = ENV["UPS_PASSWORD"]
    UPS_ORIGIN_ACCOUNT = ENV["UPS_ORIGIN_ACCOUNT"]
    UPS_ORIGIN_NAME = ENV["UPS_ORIGIN_NAME"]


  def initialize(origin, desitination, packages)
    @origin = origin
    @destination = destination
    @packages = [ ]
  end

  def package(weight, length, width, height)
    package = Package.new(weight * 16,[length, width, height], units: :imperial)
    return package
  end

  def origin
    origin = Location.new(country: "US", state: "WA", city: "Seattle", postal_code: "98101")
    return origin
  end

  def ups(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: 'auntjudy', password: 'secret', key: 'xml-access-key')
    response = ups.find_rates(origin, destination, packages)
    return response
  end
end
