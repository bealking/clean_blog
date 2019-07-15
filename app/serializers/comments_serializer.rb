class CommentsSerializer
  def initialize(comment)
    @comment = comment
  end

  def as_json
    @comment.to_h
  end
end
