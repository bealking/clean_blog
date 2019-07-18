require_relative '../entities'

class BlogApp::Entities::User < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    email
    password
  ]
  attr_accessor *ATTRIBUTES

  validates_presence_of :password, :email
  validates_length_of :password, minimum: 6
end
