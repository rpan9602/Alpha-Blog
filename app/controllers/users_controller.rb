class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index # show users list
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 5) # list 5 per page
  end
  
  def new
    @user = User.new
  end
  
  def create
    #debugger
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    # don't need line below if using before_action at top line 2.
    # @user = User.find(params[:id])	# same as articles
  end
  
  def update
    # don't need line below if using before_action at top line 2.
    # @user = User.find(params[:id])	# same as articles
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
      
  end
  
  def show
    # don't need line below if using before_action at top line 2.
    # @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all artiles created by user have been deleteed"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end  
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end  
  end
  
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end  
  end
end