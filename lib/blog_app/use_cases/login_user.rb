require_relative '../use_cases'

class BlogApp::UseCases::LoginUser
  def initialize(users_repo:, controller:)
    @users_repo = users_repo
    @controller = controller
  end

  def execute(params)
    @users_repo.login(params, @controller)
  end
end
