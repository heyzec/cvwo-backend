class SessionsController < ApplicationController
  
  # GET /.../status
  def index
    if !is_signed_in?
      render plain: ""
    else
      render plain: current_user.email
    end
  end
  

  # POST /.../signin
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.is_password?(user_params[:password])
      session[:user_id] = user.id  # Better than cookies[...], prevents tampering
      head :ok
    else
      head :unauthorized
    end
  end
  
  # GET /.../signout
  def destroy
    session[:user_id] = nil
  end
  

  def callback
    # get temporary GitHub code...
    

    params = request.env['rack.request.query_hash']

    if !params['error'].nil?
      redirect_to ENV['APP_FRONTEND_URL'] + "/auth?outcome=failure&message=#{params['error_description']}"
      return
    end

    session_code = params['code']

    # ... and POST it back to GitHub
    result = JSON.parse(RestClient.post('https://github.com/login/oauth/access_token',
      {
        :client_id => ENV['AUTH_GITHUB_CLIENT_ID'],
        :client_secret => ENV['AUTH_GITHUB_SECRET_ID'],
        :code => session_code
      },
      :accept => :json
    ))
  
    # extract the token and granted scopes
    access_token = result['access_token']
   
    if access_token.nil?
      render plain: "Something odd has occured...", status: 505
    end
    

    user_details = JSON.parse(RestClient.get('https://api.github.com/user',
      {"Authorization" => "token #{access_token}"}
    ))
    
    user_id = user_details['id']
    user_emails = JSON.parse(RestClient.get('https://api.github.com/user/emails',
      {"Authorization" => "token #{access_token}"}
    ))
    user_primary_email = user_emails.select{|email| email["primary"]}[0]['email']

    if User.exists?(github_id: user_id)
      user = User.find_by(github_id: user_id)
    else
      user = User.new(email: user_primary_email, github_id: user_id)
      if !user.save
        render plain: user.errors.full_messages.to_sentence, status: :bad_request and return
      end
    end

    session[:user_id] = user.id  # From SessionsController - logs them in too
    redirect_to ENV['APP_FRONTEND_URL'] + "/auth?outcome=success"

  end

  
  
  private
  def user_params  # Parameter white listing
    params.require(:user).permit(:email, :password)
  end

end
