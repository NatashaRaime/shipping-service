class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :update, :destroy]

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

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    if @shipment.save
      render json: @shipment, status: :created, location: @shipment
    else
      render json: @shipment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shipments/1
  # PATCH/PUT /shipments/1.json
  def update
    @shipment = Shipment.find(params[:id])

    if @shipment.update(shipment_params)
      head :no_content
    else
      render json: @shipment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    @shipment.destroy

    head :no_content
  end

  private

    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    def shipment_params
      params[:shipment]
    end
end
