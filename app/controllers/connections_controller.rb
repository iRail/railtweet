class ConnectionsController < ApplicationController
  before_filter :authenticate, :set_admin
  
  # GET /connections
  # GET /connections.xml
  def index
    @connections = Connection.all
    respond_with(@connections)
  end

  # GET /connections/1
  # GET /connections/1.xml
  def show
    @connection = Connection.find(params[:id])
    respond_with(@connection)
  end

  # GET /connections/new
  # GET /connections/new.xml
  def new
    @connection = Connection.new
    respond_with(@connection)
  end

  # GET /connections/1/edit
  def edit
    @connection = Connection.find(params[:id])
  end

  # POST /connections
  # POST /connections.xml
  def create
    @connection = Connection.new(params[:connection])
    flash[:notice] = 'Connection was successfully created.' if @connection.save
    respond_with(@connection)
  end

  # PUT /connections/1
  # PUT /connections/1.xml
  def update
    @connection = Connection.find(params[:id])
    flash[:notice] = 'Connection was successfully updated.' if @connection.update_attributes(params[:connection])
    respond_with(@connection)
  end

  # DELETE /connections/1
  # DELETE /connections/1.xml
  def destroy
    @connection = Connection.find(params[:id])
    @connection.destroy
    respond_with(@connection)
  end
end
