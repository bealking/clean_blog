require_relative '../entities'

class BlogApp::Entities::Comment < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    user_id
    body
    commentable_type
    commentable_id
  ]
  attr_accessor *ATTRIBUTES

  validates_presence_of :body, :user_id, :commentable_id, :commentable_type
end
