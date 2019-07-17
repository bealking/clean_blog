class Follow < ActiveRecord::Base
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  DOMAIN_OBJECT_CLASS = BlogApp::Entities::Follow

  def domain_object
    attrs = attributes.symbolize_keys
    DOMAIN_OBJECT_CLASS.new(attrs)
  end

end
