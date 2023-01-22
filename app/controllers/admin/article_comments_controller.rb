class Admin::ArticleCommentsController < ApplicationController
  def destroy
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end
end
