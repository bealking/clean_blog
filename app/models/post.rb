require './lib/blog_app/entities/post'

class Post < ApplicationRecord
  has_many :comments

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::Post

  def domain_object
    attrs = attributes.symbolize_keys
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
