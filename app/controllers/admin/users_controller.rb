class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      redirect_to request.referer
      # render :edit
    end
  end
  def exit
    @user = User.find(params[:id])
    # id_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(id_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end


end