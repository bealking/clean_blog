require './lib/blog_app/repos/articles_repo'
require './lib/blog_app/entities/article'

class ActiverecordArticlesRepo < BlogApp::Repos::ArticlesRepo
  def create(article)
    Article.create!(article.to_h).domain_object
  end

  def list
    Article.all.map(&:domain_object)
  end

  def find(id)
    Article.find(id).domain_object
  end
end
