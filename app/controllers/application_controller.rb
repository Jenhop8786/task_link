require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secretsecret"
  end

  get '/' do
    erb :index
  end

  helpers do

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=Check your username and password"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end#class
