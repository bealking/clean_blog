class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :follows, as: :follower
  has_many :articles
  has_many :posts

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::User

  def domain_object
    attrs = attributes.symbolize_keys
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
