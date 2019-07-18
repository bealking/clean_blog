class ArticlesSerializer
  def initialize(article)
    @article = article
  end

  def as_json
    @article.to_h
  end
end
