class SessionsController < ApplicationController

  def new
    #render a form
  end
  
  def create
    # for submit
    
    # render 'new'
    # debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id # save user id to session cache, that's backed by your browser's cookies
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new' 
    end
  end
  
  def destroy
    # logout for this user
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end