require './lib/blog_app/use_cases/add_user'
require './lib/blog_app/use_cases/login_user'
require './lib/blog_app/entities/user'

class UsersController < ApplicationController
  # POST /posts
  def create
    use_case = BlogApp::UseCases::AddUser.new(users_repo: ActiverecordUsersRepo.new)
    result = use_case.execute(BlogApp::Entities::User.new(user_params))
    if result.try(:id).present?
      render json: UsersSerializer.new(result).as_json, status: :ok
    else
      render json: {message: result, code: 'common.bad_argument', success: false}, status: :unprocessable_entity and return
    end
  end

  def new
    redirect_back_or_to root_path if logged_in?
  end

  def sign_in
    use_case = BlogApp::UseCases::LoginUser.new(users_repo: ActiverecordUsersRepo.new, controller: self)
    result = use_case.execute(BlogApp::Entities::User.new(user_params))

    if result.try(:id).present?
      render json: UsersSerializer.new(result).as_json, status: :ok
    else
      if result.nil?
        render json: {message: [t('response_message.user_no_exist')], code: 'common.bad_argument', success: false}, status: :unprocessable_entity and return
      else
        render json: {message: result, code: 'common.login_failed', success: false}, status: :unauthorized and return
      end
    end
  end

  def sign_out
    logout
    redirect_back_or_to root_path
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
