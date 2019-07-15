class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::Comment

  def domain_object
    attrs = attributes.symbolize_keys
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
