class TrackingsController < ApplicationController
  # GET /trackings
  # GET /trackings.xml
  def index
    @trackings = Tracking.all
    respond_with(@trackings)
  end

  # GET /trackings/1
  # GET /trackings/1.xml
  def show
    @tracking = Tracking.find(params[:id])
    respond_with(@tracking)
  end

  # GET /trackings/new
  # GET /trackings/new.xml
  def new
    @tracking = Tracking.new
    respond_with(@tracking)
  end

  # GET /trackings/1/edit
  def edit
    @tracking = Tracking.find(params[:id])
  end

  # POST /trackings
  # POST /trackings.xml
  def create
    @tracking = Tracking.new(params[:tracking])
    flash[:notice] = 'Tracking was successfully created.' if @tracking.save
    respond_with(@tracking)
  end

  # PUT /trackings/1
  # PUT /trackings/1.xml
  def update
    @tracking = Tracking.find(params[:id])
    flash[:notice] = 'Tracking was successfully updated.' if @tracking.update_attributes(params[:tracking])
    respond_with(@tracking)
  end

  # DELETE /trackings/1
  # DELETE /trackings/1.xml
  def destroy
    @tracking = Tracking.find(params[:id])
    @tracking.destroy
    respond_with(@tracking)
  end
end
