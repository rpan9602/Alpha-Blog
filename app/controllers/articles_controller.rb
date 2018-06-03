class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    # @articles = Article.all	# get all from database. it would be too much to display. use paginate below.
    # @articles = Article.paginate(page: params[:page]) # load default numbers per page.
    @articles = Article.paginate(page: params[:page], per_page: 5) # list 5 per page
  end
  
  def new
    @article = Article.new
  end
  
  def create
    #render plain: params[:article].inspect
    debugger
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to article_path(@article)
    else # validation fails
      render 'new'	# or render :new
    end  
    
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to article_path(@article)
    else # validation fails
      render 'edit'	# or render :new
    end  
  end
  
  def edit

  end
  
  def show

  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit or delete your own article"
        redirect_to root_path
      end  
    end
end