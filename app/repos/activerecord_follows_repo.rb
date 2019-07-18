require './lib/blog_app/repos/follows_repo'
require './lib/blog_app/entities/follow'

class ActiverecordFollowsRepo < BlogApp::Repos::FollowsRepo
  def list(params)
    Follow.where(params).all.map(&:domain_object)
  end
end
