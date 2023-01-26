class Public::FavoritesController < ApplicationController
  before_action :ensure_guest_user

  def create
    article = Article.find(params[:article_id])
    @favorite = current_user.favorites.new(article_id: article.id)
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    article = Article.find(params[:article_id])
    @favorite = current_user.favorites.find_by(article_id: article.id)
    @favorite.destroy
    redirect_to request.referer
  end

  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to request.referer , notice: 'ゲストは投稿を評価できません。'
    end
  end

end
