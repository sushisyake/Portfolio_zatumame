class Public::GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end
end
