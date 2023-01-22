class Public::ArticlesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @article = Article.find(params[:id])
    @article_comment = ArticleComment.new
  end

  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    #@article.genre_id = 1122
    if @article.save!
      redirect_to article_path(@article), notice: "You have created article successfully."
    else
      @articles = Article.all
      render 'index'
    end
  end

  private

  def article_params
    params.require(:article).permit(:question, :answer, :genre_id)
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end
end