class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # helper_method :current_user
  helper_method :is_signed_in?
  
  def is_signed_in?
    !current_user.nil?
  end
  
  
  def ensure_current_user
    if !is_signed_in?
      render plain: "hi", :status => :unauthorized
    end
  end
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end
