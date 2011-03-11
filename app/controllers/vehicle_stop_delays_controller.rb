class VehicleStopDelaysController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /vehicle_stop_delays
  # GET /vehicle_stop_delays.xml
  def index
    @vehicle_stop_delays = VehicleStopDelay.all
    respond_with(@vehicle_stop_delays)
  end

  # GET /vehicle_stop_delays/1
  # GET /vehicle_stop_delays/1.xml
  def show
    @vehicle_stop_delay = VehicleStopDelay.find(params[:id])
    respond_with(@vehicle_stop_delay)
  end

  # GET /vehicle_stop_delays/new
  # GET /vehicle_stop_delays/new.xml
  def new
    @vehicle_stop_delay = VehicleStopDelay.new
    respond_with(@vehicle_stop_delay)
  end

  # GET /vehicle_stop_delays/1/edit
  def edit
    @vehicle_stop_delay = VehicleStopDelay.find(params[:id])
  end

  # POST /vehicle_stop_delays
  # POST /vehicle_stop_delays.xml
  def create
    @vehicle_stop_delay = VehicleStopDelay.new(params[:vehicle_stop_delay])
    flash[:notice] = 'VehicleStopDelay was successfully created.' if @vehicle_stop_delay.save
    respond_with(@vehicle_stop_delay)
  end

  # PUT /vehicle_stop_delays/1
  # PUT /vehicle_stop_delays/1.xml
  def update
    @vehicle_stop_delay = VehicleStopDelay.find(params[:id])
    flash[:notice] = 'VehicleStopDelay was successfully updated.' if @vehicle_stop_delay.update_attributes(params[:vehicle_stop_delay])
    respond_with(@vehicle_stop_delay)
  end

  # DELETE /vehicle_stop_delays/1
  # DELETE /vehicle_stop_delays/1.xml
  def destroy
    @vehicle_stop_delay = VehicleStopDelay.find(params[:id])
    @vehicle_stop_delay.destroy
    respond_with(@vehicle_stop_delay)
  end
end
