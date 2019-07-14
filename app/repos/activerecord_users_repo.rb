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

  def query(params)
    #@controller.send(:auto_login, user)
    #@controller.send(:after_login!, user, [user.send(user.sorcery_config.username_attribute_names.first), 'secret'])
    #User.where(params).domain_object
  end
end
