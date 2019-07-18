require_relative '../use_cases'

class BlogApp::UseCases::DigComment
  def initialize(users_repo:)
    @user_repo = users_repo
  end

  def execute(user_id:, comment_id:)
    @user_repo.dig(user_id, comment_id)
  end
end
