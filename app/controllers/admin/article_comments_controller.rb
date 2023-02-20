class Admin::ArticleCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end
end
