require './lib/blog_app/repos/users_repo'
require './lib/blog_app/entities/user'

class ActiverecordUsersRepo < BlogApp::Repos::UsersRepo
  def create(user)
    User.create!(user.to_h).domain_object
  end

  def login(params, controller)
    controller.login(params[:email], params[:password])&.domain_object
    #controller.send(:after_login!, user, [user.send(user.sorcery_config.username_attribute_names.first), 'secret'])
  end

  def dig(user_id, comment_id)
    Follow.create!(follower_type: 'User', follower_id: user_id, followable_id: comment_id, followable_type: 'Comment')
    comment = Comment.find(comment_id)
    comment.commentable.increment!(:follows_count)
  end
end
