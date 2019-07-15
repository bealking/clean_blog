require './lib/blog_app/use_cases/add_comment'
require './lib/blog_app/use_cases/dig_comment'
require './lib/blog_app/use_cases/list_comments'
require './lib/blog_app/entities/comment'

class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :dig]

  # POST /comments
  def create
    use_case = BlogApp::UseCases::AddComment.new(comments_repo: ActiverecordCommentsRepo.new)
    result = use_case.execute(BlogApp::Entities::Comment.new(comment_params.merge!({user_id: current_user.id})))
    render json: CommentsSerializer.new(result).as_json
  end

  # GET /comments
  def index
    use_case = BlogApp::UseCases::ListComments.new(comments_repo: ActiverecordCommentsRepo.new)
    result = use_case.execute query_params
    render json: result.map { |post| CommentsSerializer.new(post).as_json }
  end

  def dig
    use_case = BlogApp::UseCases::DigComment.new(users_repo: ActiverecordUsersRepo.new)
    result = use_case.execute user_id: current_user.id, comment_id: params[:id]
    render json: {message: 'OK', success: false}, status: :ok
  end

  private
    def comment_params
      params.permit(:body, :commentable_id, :commentable_type)
    end

    def query_params
      params.permit(:limit, :commentable_id, :commentable_type, :page, :per_page)
    end
end
