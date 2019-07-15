require_relative '../use_cases'

class BlogApp::UseCases::AddArticle
  def initialize(articles_repo:)
    @articles_repo = articles_repo
  end

  def execute(article)
    @articles_repo.create(article)
  end
end
