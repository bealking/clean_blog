require_relative '../use_cases'

class BlogApp::UseCases::LoginUser
  def initialize(users_repo:, controller:)
    @users_repo = users_repo
    @controller = controller
  end

  def execute(user)
    @users_repo.login(user, @controller)
  end
end
