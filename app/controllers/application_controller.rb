class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  	# if there's authenticated user, return the user obj
  	# else return nil

  # 	user = User.find(session[:user_id])	# this will blow up if user_id doesn't exist in database
  # 	if user
  # 		return user
		# else
		# 	return nil
  # 	end

  	@current_user ||= User.find(session[:user_id]) if session[:user_id]

  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:error] = "Must be logged in to do that!"
  		redirect_to root_path
  	end
  end
end
