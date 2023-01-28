class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user.id)
		redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer
  end

  #フォロー中のユーザー一覧ページ処理
  def followings
    user = User.find(params[:user_id])
		@users = user.followings
  end
  
  #フォロワー一覧のページ処理
  def followers
    user = User.find(params[:user_id])
		@users = user.followers
  end
  
  #ゲストユーザーのコメントを制限
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to request.referer , notice: 'ゲストはユーザーをフォローに関する機能を利用できません'
    end
  end
  
end
