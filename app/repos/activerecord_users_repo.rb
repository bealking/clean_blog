require './lib/blog_app/repos/users_repo'
require './lib/blog_app/entities/user'

class ActiverecordUsersRepo < BlogApp::Repos::UsersRepo
  def create(user)
    if user.valid?
      User.create!(user.to_h).domain_object
    else
      user.errors.full_messages
    end
  end

  def login(user, controller)
    if user.valid?
      controller.login(user.email, user.password)&.domain_object
    else
      user.errors.full_messages
    end
  end

  def dig(user_id, comment_id)
    follow = Follow.find_or_initialize_by(follower_type: 'User', follower_id: user_id, followable_id: comment_id, followable_type: 'Comment')

    if follow.new_record?
      follow.save
      comment = Comment.find(comment_id)
      comment.commentable.increment!(:follows_count)
    end
  end
end
