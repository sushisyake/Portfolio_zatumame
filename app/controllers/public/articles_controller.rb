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
    if @article.save
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
  end

  def index
    @genres = Genre.all
    #タグ検索のための処理
    if params[:tag_ids].present?
      tag_ids = params[:tag_ids].select{|key, value| value == "1"}.keys
    end
    if tag_ids.present? && tag_ids[0].present?
      @articles = Tag.find(tag_ids[0]).articles
      tag_ids.delete_at(0)
      tag_ids.each do |tag_id|
        @articles = @articles & Tag.find(tag_id).articles
      end
      @articles_count = @articles.count
      @articles = Kaminari.paginate_array(@articles).page(params[:page])
    else
      @articles_count = Article.all.count
      @articles = Article.all.page(params[:page])
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