class Public::UnfavoritesController < ApplicationController
  before_action :ensure_guest_user
  
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

  #ゲストユーザーのいいねを制限
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to request.referer , notice: 'ゲストは投稿を評価できません。'
    end
  end

end
