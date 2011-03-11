class SessionController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    # raise auth["extra"]["user_hash"]["profile_background_image_url"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, session[:user_data])
    session[:user_data] = nil
    session[:user_id] = user.id
    redirect_to root_url, :notice => t('signed_in')
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t('signed_out')
  end
end
