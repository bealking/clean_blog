require './lib/blog_app/use_cases/add_user'
require './lib/blog_app/use_cases/login_user'
require './lib/blog_app/entities/user'

class UsersController < ApplicationController
  # POST /posts
  def create
    use_case = BlogApp::UseCases::AddUser.new(users_repo: ActiverecordUsersRepo.new)
    result = use_case.execute(BlogApp::Entities::User.new(user_params))
    render json: UsersSerializer.new(result).as_json
  end

  def sign_in
    use_case = BlogApp::UseCases::LoginUser.new(users_repo: ActiverecordUsersRepo.new, controller: self)
    result = use_case.execute(user_params)

    if result.try(:id).present?
      render json: UsersSerializer.new(result).as_json
    else
      render json: {message: t('response_message.login_failed'), code: 'common.login_failed', success: false}, status: :unauthorized and return
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
