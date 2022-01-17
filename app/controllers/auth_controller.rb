class AuthController < ApplicationController
  
  def callback_github
    
    github_token_uri = 'https://github.com/login/oauth/access_token'
    github_api_user_uri = 'https://api.github.com/user'
    github_api_user_emails_uri = 'https://api.github.com/user/emails'

    # get temporary GitHub code...
    params = request.env['rack.request.query_hash']
    if !params['error'].nil?
      redirect_to "#{ENV['APP_FRONTEND_URL']}/auth?outcome=failure&message=#{params['error_description']}"
      return
    end
    session_code = params['code']

    # ... and POST it back to GitHub
    result = JSON.parse(RestClient.post(github_token_uri,
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
      message = "Something wrong has occured, please try again :("
      return_to_frontend(false, message)
    end

    user_details = JSON.parse(RestClient.get(github_api_user_uri,
      {"Authorization" => "token #{access_token}"}
    ))
    user_emails = JSON.parse(RestClient.get(github_api_user_emails_uri,
      {"Authorization" => "token #{access_token}"}
    ))

    user_id = user_details['id']
    user_email = user_emails.select{|email| email['primary']}[0]['email']

    if User.exists?(github_id: user_id)
      # If user has already linked their GitHub account before
      user = User.find_by(github_id: user_id)

    elsif User.exists?(email: user_email)
      # If user has not done so, but created an account using the same email (either basic account creation or Google)
      user = User.find_by(email: user_email)
      user.update(github_id: user_id)
        message = "You have linked your GitHub account!"
    else
      # New user, create account
      user = User.new(email: user_email, github_id: user_id)
      if !user.save
        message = "Something wrong has occured, please try again :("
        return_to_frontend(false, message)
      end
        message = "You have created an account via your GitHub account!"
    end

    session[:user_id] = user.id
    return_to_frontend(true, message)

  end

  def callback_google
    
    google_token_uri = 'https://www.googleapis.com/oauth2/v4/token'
    
    params = request.env['rack.request.query_hash']
    session_code = params['code']
    
    result = JSON.parse(RestClient.post(google_token_uri,
      {
        'grant_type' => 'authorization_code',
        'client_id' => ENV['AUTH_GOOGLE_CLIENT_ID'],
        'client_secret' => ENV['AUTH_GOOGLE_SECRET_ID'],
        'redirect_uri' => "#{ENV['APP_BACKEND_URL']}/api/v1/auth/google",
        'code' => session_code
      },
      :accept => :json
    ))
    
    id_token = result['id_token']
    user_info = JSON.parse(Base64.decode64(id_token.split('.')[1]))  # Parse the resulting JWT format
    
    user_id = user_info['sub']
    user_email = user_info['email']
    user_email_verified = user_info['email_verified']
    
  
    message = nil
    if User.exists?(google_id: user_id)
      # If user has already linked their Google account before
      user = User.find_by(google_id: user_id)
      
    else
      if !user_email_verified
        # Refuse to do anything with user email if they have not verified it with Google before
        message = "Your email associated with Google has not been verified before."
        return_to_frontend(false, message)
      end

      if User.exists?(email: user_email)
        # If user has not done so, but created an account using the same email (either basic account creation or GitHub)
        user = User.find_by(email: user_email)
        user.update(google_id: user_id)
        message = "You have linked your Google account!"
      else
        # New user, create account
        user = User.new(email: user_email, google_id: user_id)
        if !user.save
          message = "Something wrong has occured, please try again :("
          return_to_frontend(false, message)
        end
        message = "You have created an account via your Google account!"
      end
    end

    session[:user_id] = user.id  # From SessionsController - logs them in too
    return_to_frontend(true, message)
  end

  
  private
  def return_to_frontend(success, message)
    redirect_to "#{ENV['APP_FRONTEND_URL']}/auth?success=#{success}#{message.nil? ? "" : "&message=#{message}"}"
  end
end
