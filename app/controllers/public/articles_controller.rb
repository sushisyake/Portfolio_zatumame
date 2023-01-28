class Public::ArticlesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:new]

  def show
    @article = Article.find(params[:id])
    @genres = Genre.all
    @article_comment = ArticleComment.new

    if params[:tag_ids]
      @articles = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_articles = Tag.find_by(name: key).articles
          @articles = @articles.empty? ? tag_articles : @articles & tag_articles
        end
      end
    end

  end

  def new
    @article = Article.new

    if params[:tag]
      Tag.create(name: params[:tag])
      render :new
    end

  end

  def index
    @articles = Article.all.page(params[:page])
    @genres = Genre.all

    if params[:tag_ids]
      @articles = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_articles = Tag.find_by(name: key).articles
          @articles = @articles.empty? ? tag_articles : @articles & tag_articles
        end
      end
    end

  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save!
      redirect_to article_path(@article), notice: "You have created article successfully."
    else
      @articles = Article.all
      render 'new', notice: "You have created article successfully."
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end


  private

  def article_params
    params.require(:article).permit(:question, :answer, :genre_id, tag_ids: [])
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end

  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to articles_path , notice: 'ゲストは投稿できません。'
    end
  end

end