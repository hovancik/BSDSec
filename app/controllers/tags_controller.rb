class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.order("created_at desc").limit(10)
  end
end
