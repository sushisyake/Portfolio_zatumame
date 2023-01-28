class Public::ArticlesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:new]

  def new
    @article = Article.new
    #タグを登録するときの処理
    if params[:tag]
      Tag.create(name: params[:tag])
      render :new
    end
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save!
      redirect_to article_path(@article), notice: "投稿に成功しました"
    else
      @articles = Article.all
      render 'new', notice: "投稿に失敗しました"
    end
  end
  
  def show
    @article = Article.find(params[:id])
    @genres = Genre.all
    @article_comment = ArticleComment.new
    #タグを検索する処理
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

  def index
    @articles = Article.all.page(params[:page])
    @genres = Genre.all
    #タグを検索する処理
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

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path , notice: '投稿を削除しました'
  end
  
  private

  def article_params
    params.require(:article).permit(:question, :answer, :genre_id, tag_ids: [])
  end

  #投稿したユーザーがログインしているユーザーか確認
  def ensure_correct_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end

  #ゲストユーザーのコメントを制限
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to articles_path , notice: 'ゲストは投稿できません'
    end
  end

end