require_relative '../entities'

class BlogApp::Entities::Follow < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    followable_id
    followable_type
    follower_type
    follower_id
  ]
  attr_accessor *ATTRIBUTES
end
