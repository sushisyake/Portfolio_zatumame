class Public::FavoritesController < ApplicationController
  before_action :ensure_guest_user

  def create
    @article = Article.find(params[:article_id])
    @favorite = current_user.favorites.new(article_id: @article.id)
    @favorite.save
    # 非同期通信でrenderやredirect_toを使うと、
    # index.html.erbではなくindex.js.erbを探してしまう。
    # これらを書かない場合は、アクション名.js.erbが必要。(create.js.erbなど)
    # redirect_to request.referer
  end

  def destroy
    @article = Article.find(params[:article_id])
    @favorite = current_user.favorites.find_by(article_id: @article.id)
    @favorite.destroy
    # redirect_to request.referer
  end

  #ゲストユーザーのいいねを制限
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to request.referer , notice: 'ゲストは投稿を評価できません。'
    end
  end

end
