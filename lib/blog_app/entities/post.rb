require_relative '../entities'

class BlogApp::Entities::Post < BlogApp::Entities::Base
  ATTRIBUTES = BlogApp::Entities::Base::ATTRIBUTES | %i[
    user_id
    title
    body
    follows_count
  ]
  attr_accessor *ATTRIBUTES

  validates_presence_of :title, :body, :user_id

  def to_h
    super.tap {|memo| memo[:follows_count] ||= 0}
  end
end
