class VehiclesController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /vehicles
  # GET /vehicles.xml
  def index
    @search = Vehicle.search(params[:search])
    @vehicles = @search.paginate(:per_page => 40, :page=>params[:page])
    respond_with(@vehicles)
  end

  # GET /vehicles/1
  # GET /vehicles/1.xml
  def show
    @vehicle = Vehicle.find(params[:id])
    respond_with(@vehicle)
  end

  # GET /vehicles/new
  # GET /vehicles/new.xml
  def new
    @vehicle = Vehicle.new
    respond_with(@vehicle)
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  # POST /vehicles
  # POST /vehicles.xml
  def create
    @vehicle = Vehicle.new(params[:vehicle])
    flash[:notice] = 'Vehicle was successfully created.' if @vehicle.save
    respond_with(@vehicle)
  end

  # PUT /vehicles/1
  # PUT /vehicles/1.xml
  def update
    @vehicle = Vehicle.find(params[:id])
    flash[:notice] = 'Vehicle was successfully updated.' if @vehicle.update_attributes(params[:vehicle])
    respond_with(@vehicle)
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.xml
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    respond_with(@vehicle)
  end
end
