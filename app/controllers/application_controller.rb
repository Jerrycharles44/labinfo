require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  use Rack::Flash
  
  set :session_secret, "secret_workshops"
  set :views, Proc.new { File.join(root, "../views/") }

  # User will only see homepage IF they are not currently logged in
  get '/' do
    if logged_in?
        redirect to "/workshops"
    else
        erb :index
    end
  end

  # HELPER METHODS
  helpers do

    # Check if a user is logged into their account
    def logged_in?
      !!current_user
    end
    
    # Find current user
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    # Find a workshop based on id
    def find_workshop(id)
      @workshop ||= Workshop.find_by_id(id)
    end

    # Display workshop difficulty based on level
    def workshop_difficulty(num)
      case num
        when 0
          "Easy"
        when 1
          "Intermediate"
        else
          "Advanced"
      end
    end

    # Display workshop registration status based on confirmation
    def registration_status(num)
      case num
        when 0
          "Pending"
        when 1
          "Waitlisted"
        else
          "Enrolled"
        end
    end
  end
end