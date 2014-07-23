class TagsController < ApplicationController
  def show
    @tag = Tag.friendly.find(params[:id])
    @articles = @tag.articles.order("created_at desc").page(params[:page])
  end
end
