# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  #ゲストログインの処理
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストとしてログインしました'
  end

  def after_sign_in_path_for(resource)
      user_path(resource)
  end

  protected

  #退会している場合の処理
  def user_state
    #入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    #取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
      #一致しているが退会済みの場合：サインアップにリダイレクト
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_user_registration_path
    elsif (@user.valid_password?(params[:user][:password]) == false) && (@user.is_deleted == true)
      flash[:notice] = "パスワードが違います"
    else
      flash[:notice] = "必要項目を入力してください"
    end
  end

end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
