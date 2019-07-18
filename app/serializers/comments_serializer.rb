class CommentsSerializer
  # follows -> 当前用户点赞过的评论
  def initialize(comment, follows=[])
    @comment = comment
    @follows = follows
  end

  def as_json
    follow_ids = @follows.map(&:followable_id)
    @comment
    @comment.to_h.tap do |result|
      result[:is_followed] = (follow_ids.include?(result[:id]) ? true : false)
      result[:user_email] = @comment.user.email if @comment.user.present?
      result[:created_at] = @comment.created_at.try(:to_s, :db)
    end
  end
end
