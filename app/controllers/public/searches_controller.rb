class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  #ユーザーと投稿の検索処理 if文でUserとArticleを区別できる
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:word])
    else
      @articles = Article.looks(params[:word])
    end
  end
end

