require_relative '../entities'

class BlogApp::Entities::User < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    email
    password
  ]
  attr_accessor *ATTRIBUTES
end
