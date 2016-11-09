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
end
