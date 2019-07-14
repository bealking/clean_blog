require_relative '../use_cases'

class BlogApp::UseCases::ListPosts
  def initialize(posts_repo:)
    @posts_repo = posts_repo
  end

  def execute
    @posts_repo.list
  end
end
