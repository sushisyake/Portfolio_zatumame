class Public::UnfavoritesController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    @unfavorite = current_user.unfavorites.new(article_id: article.id)
    @unfavorite.save
    redirect_to request.referer
  end

  def destroy
    article = Article.find(params[:article_id])
    @unfavorite = current_user.unfavorites.find_by(article_id: article.id)
    @unfavorite.destroy
    redirect_to request.referer
  end
end
