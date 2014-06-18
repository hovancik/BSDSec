class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    private
    
      def article_params
          params.require(:article).permit(:from,:title,:body)
      end
end
