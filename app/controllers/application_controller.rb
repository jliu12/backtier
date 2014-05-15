require 'houston'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :fetch_user
  before_filter :init_apns

  def fetch_user
  	if session[:user_id]
		  @currUser = User.find_by_id(session[:user_id])
	  else 
		  @currUser = nil
	  end
  end
  
  def init_apns

  end

end
