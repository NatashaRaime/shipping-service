class ShipmentsController < ApplicationController

  def create
    shipment = Shipment.new(params[:shipment][:origin], params[:shipment][:destination], params[:shipment][:packages])

    ups_rates = Shipment.ups(shipment.origin, shipment.destination, shipment.packages)

    usps_rates = Shipment.usps(shipment.origin, shipment.destination, shipment.packages)

    render json: {"ups": ups_rates, "usps": usps_rates}, status: :created
  end

  #private
  # def shipment_params
  #   params.require(:shipment).permit(:origin, :destination, :packages)
  # end
end
