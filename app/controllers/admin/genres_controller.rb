class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

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

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private
  #ジャンルのストロングパラメーター
  def genre_params
    params.require(:genre).permit(:name)
  end
end
