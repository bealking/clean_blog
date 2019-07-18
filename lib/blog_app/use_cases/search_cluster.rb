require_relative '../use_cases'

class BlogApp::UseCases::SearchCluster
  def initialize(clusters_repo:)
    @clusters_repo = clusters_repo
  end

  def execute(params)
    @clusters_repo.search(params)
  end
end
