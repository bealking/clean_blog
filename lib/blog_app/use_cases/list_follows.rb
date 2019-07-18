require_relative '../use_cases'

class BlogApp::UseCases::ListFollows
  def initialize(follows_repo:)
    @follows_repo = follows_repo
  end

  def execute(params)
    @follows_repo.list(params)
  end
end
