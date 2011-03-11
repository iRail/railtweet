class OneWayTripsController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /one_way_trips
  # GET /one_way_trips.xml
  def index
    @search = OneWayTrip.search(params[:search])
    @one_way_trips = @search.paginate(:per_page => 40, :page=>params[:page])
    respond_with(@one_way_trips)
  end

  # GET /one_way_trips/1
  # GET /one_way_trips/1.xml
  def show
    @one_way_trip = OneWayTrip.find(params[:id])
    respond_with(@one_way_trip)
  end

  # GET /one_way_trips/new
  # GET /one_way_trips/new.xml
  def new
    @one_way_trip = OneWayTrip.new
    respond_with(@one_way_trip)
  end

  # GET /one_way_trips/1/edit
  def edit
    @one_way_trip = OneWayTrip.find(params[:id])
  end

  # POST /one_way_trips
  # POST /one_way_trips.xml
  def create
    @one_way_trip = OneWayTrip.new(params[:one_way_trip])
    flash[:notice] = 'OneWayTrip was successfully created.' if @one_way_trip.save
    respond_with(@one_way_trip)
  end

  # PUT /one_way_trips/1
  # PUT /one_way_trips/1.xml
  def update
    @one_way_trip = OneWayTrip.find(params[:id])
    flash[:notice] = 'OneWayTrip was successfully updated.' if @one_way_trip.update_attributes(params[:one_way_trip])
    respond_with(@one_way_trip)
  end

  # DELETE /one_way_trips/1
  # DELETE /one_way_trips/1.xml
  def destroy
    @one_way_trip = OneWayTrip.find(params[:id])
    @one_way_trip.destroy
    respond_with(@one_way_trip)
  end
end
