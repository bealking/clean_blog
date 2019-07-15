require_relative '../use_cases'

class BlogApp::UseCases::FindArticle
  def initialize(articles_repo:)
    @articles_repo = articles_repo
  end

  def execute(id)
    @articles_repo.find(id)
  end
end
