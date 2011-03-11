class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_language, :languages_select, :is_admin
  
  respond_to :html
  
  before_filter :set_language
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" and password == "irail"
    end
  end
  
  def set_language
    session[:language] = params[:language] if params[:language]
    I18n.locale = session[:language]
  end
  
  def languages_select
    { "Nederlands" => "nl",
      "Francais" => "fr",
      "English" => "en" }
  end
  
  def set_admin
    @admin = true
  end
  
  def is_admin
    @admin
  end
  
  private
  
  def current_user
    unless @current_user
      if session[:user_id]
        user = User.where(:id=>session[:user_id]).first
        if user
          @current_user = user
        else
          @current_user = session[:user_id] = nil
        end
      else
        nil
      end
    else
      @current_user
    end
  end
  
  def current_language
    @current_language ||= session[:language] || "en"
  end
  
end
