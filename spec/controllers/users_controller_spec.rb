require 'rails_helper'

require './lib/blog_app/entities/user'
require './lib/blog_app/use_cases/add_user'
#require './lib/blog_app/use_cases/login_user'
#require './lib/blog_app/use_cases/logout_user'

RSpec.describe UsersController, type: :controller do
  # user login
  describe 'POST /sign_in' do
    subject(:call) do
      post :sign_in, params: params
    end

    let(:params) do
      {
        user: {
          email: 'bealking@gmail.com',
          password: '123456789',
        }
      }
    end

    let(:strong_params) {
      ActionController::Parameters.new(email: 'bealking@gmail.com', password: '123456789')
    }

    let(:use_case) do
      instance_double(BlogApp::UseCases::LoginUser, execute: strong_params)
    end

    it 'executes the add-post use-case with the post', skip: true do
      User.create(email: 'bealking@gmail.com', password: '123456789')
      call
      expect(use_case).to have_received(:execute).with(strong_params)
    end

    context 'serializes and renders the response' do
      it 'login failed' do
        call

        result = Oj.load(response.body, symbol_keys: true)
        expect(result[:code]).to eq 'common.bad_argument'
      end

      it 'login succeed' do
        user = User.create(email: 'bealking@gmail.com', password: '123456789')
        call

        result = Oj.load(response.body, symbol_keys: true)
        expect(result[:email]).to eq user.email
        expect(session[:user_id]).to eq user.id.to_s
      end
    end
  end

  describe 'POST /' do
    subject(:call) do
      post :create, params: params
    end

    let(:params) do
      {
        user: {
          email: 'bealking@gmail.com',
          password: '123456789',
        }
      }
    end

    let(:result) { BlogApp::Entities::User.new(params[:user]) }
    let(:use_case) do
      instance_double(BlogApp::UseCases::AddUser, execute: result)
    end

    before do
      allow(BlogApp::UseCases::AddUser).to receive(:new).and_return(use_case)
      allow_any_instance_of(BlogApp::Entities::User).to receive(:id).and_return(true)
    end

    it 'executes the add-post use-case with the post' do
      call
      expect(use_case).to have_received(:execute).with(BlogApp::Entities::User.new(params[:user]))
    end

    it 'serializes and renders the response' do
      call

      expected = params[:user].merge(created_at: nil, updated_at: nil, id: nil)
      expect(Oj.load(response.body, symbol_keys: true)).to eq(expected)
    end
  end
end
