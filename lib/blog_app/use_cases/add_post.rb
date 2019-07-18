require_relative '../use_cases'

class BlogApp::UseCases::AddPost
  def initialize(posts_repo:)
    @posts_repo = posts_repo
  end

  def execute(post)
    @posts_repo.create(post)
  end
end
