require_relative '../entities'

class BlogApp::Entities::Article < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    user_id
    title
    body
    follows_count
  ]
  attr_accessor *ATTRIBUTES

  def to_h
    super.tap {|memo| memo[:follows_count] ||= 0}
  end
end
