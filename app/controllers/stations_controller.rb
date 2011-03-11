class StationsController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /stations
  # GET /stations.xml
  def index
    @search = Station.search(params[:search])
    @stations = @search.paginate(:per_page => 40, :page=>params[:page])
    respond_with(@stations)
  end

  # GET /stations/1
  # GET /stations/1.xml
  def show
    @station = Station.find(params[:id])
    respond_with(@station)
  end

  # GET /stations/new
  # GET /stations/new.xml
  def new
    @station = Station.new
    respond_with(@station)
  end

  # GET /stations/1/edit
  def edit
    @station = Station.find(params[:id])
  end

  # POST /stations
  # POST /stations.xml
  def create
    @station = Station.new(params[:station])
    flash[:notice] = 'Station was successfully created.' if @station.save
    respond_with(@station)
  end

  # PUT /stations/1
  # PUT /stations/1.xml
  def update
    @station = Station.find(params[:id])
    flash[:notice] = 'Station was successfully updated.' if @station.update_attributes(params[:station])
    respond_with(@station)
  end

  # DELETE /stations/1
  # DELETE /stations/1.xml
  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    respond_with(@station)
  end
end
