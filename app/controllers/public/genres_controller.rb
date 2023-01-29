class Public::GenresController < ApplicationController

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
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
  end
