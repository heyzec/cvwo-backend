class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # before_action :delay  # Used for simulating a delayed response with backend
  
  def delay
    sleep 3
  end

  # helper_method :is_signed_in?
  
  def is_signed_in?
    !current_user.nil?
  end
  
  
  def ensure_current_user
    if !is_signed_in?
      head :unauthorized
    end
  end
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

end
