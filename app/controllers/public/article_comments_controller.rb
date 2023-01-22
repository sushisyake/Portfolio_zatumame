class Public::ArticleCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    @comment = current_user.article_comments.new(article_comment_params)
    @comment.article_id = article.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private
  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
end
