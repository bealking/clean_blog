require './lib/blog_app/use_cases/add_article'
require './lib/blog_app/use_cases/find_article'
require './lib/blog_app/entities/article'

class ArticlesController < ApplicationController
  before_action :require_login, only: [:create]

  # POST /articles
  def create
    use_case = BlogApp::UseCases::AddArticle.new(articles_repo: ActiverecordPostsRepo.new)
    result = use_case.execute(BlogApp::Entities::Article.new(article_params.merge!({user_id: current_user.id})))
    render json: ArticlesSerializer.new(result).as_json
  end

  def show
    use_case = BlogApp::UseCases::FindArticle.new(articles_repo: ActiverecordPostsRepo.new)
    result = use_case.execute(params[:id])
    render json: ArticlesSerializer.new(result).as_json
  end

  def article_params
    params.permit(:title, :body)
  end
end
