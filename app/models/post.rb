require './lib/blog_app/entities/post'
require './lib/blog_app/entities/user'

class Post < ApplicationRecord
  has_many :comments
  belongs_to :user

  searchkick

  def search_data
    {
      object_type: 'post',
      title: title,
      follows_count: follows_count,
      user_email: user.email
    }
  end

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::Post

  def domain_object
    attrs = attributes.symbolize_keys
    attrs[:kind] = 'post'
    attrs[:follows_count] ||= 0
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
