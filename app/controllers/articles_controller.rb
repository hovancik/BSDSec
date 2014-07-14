class ArticlesController < ApplicationController
    def index
        @articles = Article.all.order("created_at desc").limit(10)
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    private
    
      def article_params
          params.require(:article).permit(:from,:title,:body,:tag_list)
      end
end
