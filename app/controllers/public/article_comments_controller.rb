class Public::ArticleCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    @comment = current_customer.article_comments.new(article_comment_params)
    @comment.article_id = article.id
    @comment.save
  end

  def destroy
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
  end

  private
  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
end
