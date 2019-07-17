class ArticlesSerializer
  def initialize(article)
    @article = article
  end

  def as_json
    p @article
    @article.to_h
  end
end
