class Public::ArticlesController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

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
    @article.customer_id = current_customer.id
    @article.genre_id = 1122
    if @article.save
      redirect_to article_path(@article), notice: "You have created article successfully."
    else
      @articles = Article.all
      render 'index'
    end
  end

  private

  def article_params
    params.require(:article).permit(:question, :answer)
  end

  def ensure_correct_customer
    @article = Article.find(params[:id])
    unless @article.customer == current_customer
      redirect_to articles_path
    end
  end
end