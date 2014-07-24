class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at desc").page(params[:page])
      
    respond_to do |format|
      format.html
      format.atom
    end
  end
  
  def show
      @article = Article.friendly.find(params[:id])
  end
  
  
  
  private
  
    def article_params
        params.require(:article).permit(:from,:title,:body,:tag_list)
    end
end
