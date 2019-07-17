require './lib/blog_app/entities/article'

class Article < ApplicationRecord
  has_many :comments
  belongs_to :user

  searchkick

  def search_data
    {
      id: id,
      type: 'article',
      title: title,
      follows_count: follows_count,
      user_email: user.email
    }
  end

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::Article

  def domain_object
    attrs = attributes.symbolize_keys
    attrs[:kind] = 'article'
    attrs[:follows_count] ||= 0
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
