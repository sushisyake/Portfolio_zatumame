class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :confirm]
   before_action :ensure_guest_user, only: [:edit, :confirm]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page])
    @article = Article.new
  end

  def index
    @users = User.all
    @article = Article.new

  end

  def update
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      flash[:notice] = "ゲストはニックネームを変更できません"
      redirect_to request.referer and return
    end
    @user.update(user_params)
    if @user.save
      flash[:notice] = "ニックネームが変更されました"
      redirect_to request.referer
    else
      flash[:notice] = "ニックネームを入力してください。"
      redirect_to request.referer
    end
  end

  def confirm
    @user = current_user
  end

  def exit
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用をお待ちしております。"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:article_id)
    @favorite_articles = Article.find(favorites)
  end

  def unfavorites
    @user = User.find(params[:id])
    unfavorites = Unfavorite.where(user_id: @user.id).pluck(:article_id)
    @unfavorite_articles = Article.find(unfavorites)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
   login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'プロフィール編集と退会はできません。'
    end
  end

end