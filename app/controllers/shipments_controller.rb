class ShipmentsController < ApplicationController
  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = Shipment.all
    render json: @shipments
  end
  # GET /shipments/1
  # GET /shipments/1.json
  def show
    render json: @shipment
  end

  def search
    pets = Pet.search(params[:query])
    render json: pets, only: [:age, :id, :human, :name]
  end

  def create
    puts ">>>>>>>>>>>>>>>>>>params are: #{params}"
    # shipment = Shipment.new(shipment_params)

    shipment = Shipment.new(params[:shipment][:origin], params[:shipment][:destination], params[:shipment][:packages])

    ups_rates = Shipment.ups(shipment.origin, shipment.destination, shipment.packages)

    puts ">>>>>>>>>>>>>>>>> ups: #{ups_rates}"

    usps_rates = Shipment.usps(shipment.origin, shipment.destination, shipment.packages)

    puts ">>>>>>>>>>>>>>>>> usps: #{usps_rates}"

    # binding.pry

    # shipment.save
    render json: {}, status: :created
  end

  private

  def shipment_params
    params.require(:shipment).permit(:origin, :destination, :packages)
  end
end
