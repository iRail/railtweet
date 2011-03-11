class VehicleStopsController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /vehicle_stops
  # GET /vehicle_stops.xml
  def index
    @search = VehicleStop.search(params[:search])
    @vehicle_stops = @search.includes(:station, :vehicle).paginate(:per_page => 40, :page=>params[:page])
    respond_with(@vehicle_stops)
  end

  # GET /vehicle_stops/1
  # GET /vehicle_stops/1.xml
  def show
    @vehicle_stop = VehicleStop.find(params[:id])
    respond_with(@vehicle_stop)
  end

  # GET /vehicle_stops/new
  # GET /vehicle_stops/new.xml
  def new
    @vehicle_stop = VehicleStop.new
    respond_with(@vehicle_stop)
  end

  # GET /vehicle_stops/1/edit
  def edit
    @vehicle_stop = VehicleStop.find(params[:id])
  end

  # POST /vehicle_stops
  # POST /vehicle_stops.xml
  def create
    @vehicle_stop = VehicleStop.new(params[:vehicle_stop])
    flash[:notice] = 'VehicleStop was successfully created.' if @vehicle_stop.save
    respond_with(@vehicle_stop)
  end

  # PUT /vehicle_stops/1
  # PUT /vehicle_stops/1.xml
  def update
    @vehicle_stop = VehicleStop.find(params[:id])
    flash[:notice] = 'VehicleStop was successfully updated.' if @vehicle_stop.update_attributes(params[:vehicle_stop])
    respond_with(@vehicle_stop)
  end

  # DELETE /vehicle_stops/1
  # DELETE /vehicle_stops/1.xml
  def destroy
    @vehicle_stop = VehicleStop.find(params[:id])
    @vehicle_stop.destroy
    respond_with(@vehicle_stop)
  end
end
