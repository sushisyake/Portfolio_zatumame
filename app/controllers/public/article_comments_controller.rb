class Public::ArticleCommentsController < ApplicationController
  before_action :ensure_guest_user

  def create
    article = Article.find(params[:article_id])
    @comment = current_user.article_comments.new(article_comment_params)
    @comment.article_id = article.id
    @comment.save
    redirect_to request.referer, notice: 'コメントを投稿しました'
  end

  def destroy
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer, notice: 'コメントを削除しました'
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end

  #ゲストユーザーのコメントを制限
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      redirect_to article_path , notice: 'ゲストユーザーはコメントできません'
    end
  end

end
