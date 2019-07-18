require_relative '../use_cases'

class BlogApp::UseCases::AddComment
  def initialize(comments_repo:)
    @comments_repo = comments_repo
  end

  def execute(comment)
    @comments_repo.create(comment)
  end
end
