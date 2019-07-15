require './lib/blog_app/repos/comments_repo'
require './lib/blog_app/entities/comment'

class ActiverecordCommentsRepo < BlogApp::Repos::CommentsRepo
  def create(comment)
    Comment.create!(comment.to_h).domain_object
  end

  def list(params)
    Comment.where(commentable_type: params[:commentable_type], commentable_id: params[:commentable_id]).limit(params[:limit] || 3).order(created_at: :desc).all.map(&:domain_object)
  end
end
