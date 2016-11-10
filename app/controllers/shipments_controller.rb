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

    puts ">>>>>>>>>>>>>>>>shipment: #{shipment}"
    # shipment.save
    render json: {}, status: :created
  end

  private

  def shipment_params
    params.require(:shipment).permit(:origin, :destination, :packages)
  end
end
