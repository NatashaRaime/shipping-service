class Shipment < ActiveRecord::Base
  include ActiveShipping::Shipping
  # this needs to be in the model for petsy
  #cylinder = boolean
  # validates :name, presence: true
  # validates :country, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :postal_code, presence: true
  # validates :length, presence: true
  # validates :width, presence: true
  # validates :height, presence: true
  # validates :weight, presence: true

  def origin
    Location.new(country: "US", state: "WA", city: "Seattle", postal_code: "98101")
  end

  def destination
    Location.new(country: country, state: state, city: city, postal_code: postal_code)
  end

  def packages
    package = Package.new(weight, [length, width, height], cylinder: cylinder)
    return package
  end

  def get_rates_from_shipper(shipper)
    response = shipper.find_rates(origin, destination, packages)
    response.rates.sort_by(&:price)
  end

  def ups_rates
    ups = UPS.new(login: UPSLOGIN, password: UPSPASSWORD, key: UPSXMLKEY)
    get_rates_from_shipper(ups)
  end

  def fedex_rates
    fedex = FedEx.new(login: "your fedex login", password: "your fedex password", key: "your fedex key", account: "your fedex account number")
    get_rates_from_shipper(fedex)
  end

  def usps_rates
    usps = USPS.new(login: 'your usps account number', password: 'your usps password')
    get_rates_from_shipper(usps)
  end
end
