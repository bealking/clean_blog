require_relative '../use_cases'

class BlogApp::UseCases::FindPost
  def initialize(posts_repo:)
    @posts_repo = posts_repo
  end

  def execute(id)
    @posts_repo.find(id)
  end
end
