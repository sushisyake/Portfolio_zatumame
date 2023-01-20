class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
   before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @article = Article.new
  end

  def index
    @users = User.all
    @article = Article.new

  end

  def edit
    @user = User.find(params[:id])
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
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end