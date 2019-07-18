require './lib/blog_app/use_cases/add_post'
require './lib/blog_app/use_cases/list_posts'
require './lib/blog_app/use_cases/find_post'
require './lib/blog_app/entities/post'
require './lib/blog_app/entities/user'

class PostsController < ApplicationController
  before_action :require_login, only: [:create]

  # POST /posts
  def create
    use_case = BlogApp::UseCases::AddPost.new(posts_repo: ActiverecordPostsRepo.new)
    result = use_case.execute(BlogApp::Entities::Post.new(post_params.merge!({user_id: current_user.id})))
    render json: PostsSerializer.new(result).as_json
  end

  # GET /posts
  def index
    use_case = BlogApp::UseCases::ListPosts.new(posts_repo: ActiverecordPostsRepo.new)
    result = use_case.execute
    render json: result.map { |post| PostsSerializer.new(post).as_json }
  end

  def show
    use_case = BlogApp::UseCases::FindPost.new(posts_repo: ActiverecordPostsRepo.new)
    @result = use_case.execute(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: PostsSerializer.new(@result).as_json}
    end
  end

  def new
  end

  private

  def post_params
    params.permit(:title, :body)
  end
end
