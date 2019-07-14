require_relative '../entities'

class BlogApp::Entities::Post < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    user_id
    title
    body
  ]
  attr_accessor *ATTRIBUTES
end
