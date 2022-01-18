class UsersController < ApplicationController

  def index
    render json: current_user
  end
  
  # POST /signup
  def create
    user = User.new(user_params)
    if user.save
      head :ok
      session[:user_id] = user.id  # From SessionsController - logs them in too
    else
      render plain: user.errors.full_messages.to_sentence, status: :bad_request
    end
  end
  
  def changepassword
    valid_params = params.permit(:old_password, :new_password)
  
    if current_user.password_digest.nil?
      head :bad_request and return
    end
    
    if !current_user.is_password?(valid_params[:old_password])
      head :unauthorized and return
    end

    begin
      current_user.update!(password: valid_params[:new_password])
    rescue ActiveRecord::RecordInvalid => e
      # Can't find the equivalent for below hence using begin..rescue
      # render plain: current_user.errors.full_messages.to_sentence, status: :bad_request
      
      render plain: e.message, status: :bad_request
      return
    end

    head :ok

  end
  
  def changeemail
    valid_params = params.permit(:email)

    if current_user.update(email: valid_params[:email])
      head :ok
    else
      render plain: "Email is invalid, please try again.", status: :bad_request
    end
  end

  # POST /.../deleteaccount
  def destroy
    ensure_current_user && return
    current_user.destroy
    session[:user_id] = nil
    head: :ok
  end


  private
  def user_params  # Parameter white listing
    params.require(:user).permit(:email, :password)
  end

end
