class UsersController < ApplicationController
  
  # POST /signup
  def create
    user = User.new(user_params)
    if user.save
      render plain: 'ok'
      session[:user_id] = user.id  # From SessionsController - logs them in too
    else
      render plain: user.errors.full_messages.to_sentence
    end
  end
  
  # POST /deleteaccount
  def destroy
  end


  private
  def user_params  # Parameter white listing
    params.require(:user).permit(:email, :password)
  end
end
