class SessionsController < ApplicationController
  
  # GET /status
  def index
    if !is_signed_in?
      render plain: ""
    else
      render plain: current_user.email
    end
  end
  

  # POST /signin
  def create
    user = User.find_by(email: user_params[:email])
    output = ""

    if user && user.is_password?(user_params[:password])
      session[:user_id] = user.id  # Better than cookies[...], prevents tampering
      output += "ok"
    else
      output += "Invalid user or password"
    end
    
    render plain: output
  end
  
  # GET /signout
  def destroy
    session[:user_id] = nil
  end
  
  private
  def user_params  # Parameter white listing
    params.require(:user).permit(:email, :password)
  end

end
