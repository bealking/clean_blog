class User < ApplicationRecord
  authenticates_with_sorcery!

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::User

  def domain_object
    attrs = attributes.symbolize_keys
    DOMAIN_OBJECT_CLASS.new(attrs)
  end
end
