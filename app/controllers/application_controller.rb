class ApplicationController < ActionController::Base
  #  all methods here are available to other controllers, but not to views by default
  
  # helper_method below tells Rails those methods are available to views.
  helper_method :current_user, :logged_in?
  
  def current_user
    # memorization: if current_user is already got from database, don't do anything.
    # if not, get it from database.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user # return true if current_user or false
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end  
  end
  
end
