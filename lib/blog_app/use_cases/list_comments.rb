require_relative '../use_cases'

class BlogApp::UseCases::ListComments
  def initialize(comments_repo:)
    @comments_repo = comments_repo
  end

  def execute(params)
    @comments_repo.list params
  end
end
