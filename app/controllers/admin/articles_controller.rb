class Admin::ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
    @article_comment = ArticleComment.new
  end

  def index
    @articles = Article.all
    @article = Article.new
  end

end