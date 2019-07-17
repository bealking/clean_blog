require './lib/blog_app/repos/posts_repo'
require './lib/blog_app/entities/post'

class ActiverecordPostsRepo < BlogApp::Repos::PostsRepo
  def create(post)
    if post.valid?
      Post.create!(post.to_h).domain_object
    else
      post.errors.full_messages
    end
  end

  def list
    Post.all.map(&:domain_object)
  end

  def find(id)
    Post.find(id).domain_object
  end
end
