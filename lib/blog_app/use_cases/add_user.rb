require_relative '../use_cases'

class BlogApp::UseCases::AddUser
  def initialize(users_repo:)
    @users_repo = users_repo
  end

  def execute(user)
    @users_repo.create(user)
  end
end
