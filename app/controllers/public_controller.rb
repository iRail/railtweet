class PublicController < ApplicationController
  def index
    unless @user = current_user
      @user = User.new(User.defaults)
    end
    @way_there = @user.way_there
    @way_back = @user.way_back
  end
  
  def trip_info
    index
  end
  
  def update
    if @user = current_user
      flash[:notice] = 'User was successfully updated.' if @user.update_attributes(params[:user])
      @way_there = @user.way_there
      @way_back = @user.way_back
      
      redirect_to root_url
    else
      session[:user_data] = params[:user]
      redirect_to "/auth/twitter"
    end
    
  end
end