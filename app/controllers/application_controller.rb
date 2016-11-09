class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
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

  def search
    pets = Pet.search(params[:query])
    render json: pets, only: [:age, :id, :human, :name]
  end
end
