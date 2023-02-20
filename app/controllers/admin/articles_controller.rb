class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @article = Article.find(params[:id])
    @genres = Genre.all
    @article_comment = ArticleComment.new
  end

  def index
    @articles = Article.all
    @article = Article.new
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

  def show
    @article = Article.find(params[:id])
    @genres = Genre.all
    @article_comment = ArticleComment.new
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path , notice: '投稿を削除しました'
  end


end