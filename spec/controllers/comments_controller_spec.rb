require 'rails_helper'

require './lib/blog_app/entities/comment'
require './lib/blog_app/entities/user'
require './lib/blog_app/use_cases/add_comment'
require './lib/blog_app/use_cases/dig_comment'
require './lib/blog_app/use_cases/list_comments'

RSpec.describe CommentsController do
  let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}

  before do
    login_user user
  end

  describe 'PUT /:id/dig' do
    subject(:call) do
      put :dig, params: {id: 3}
    end

    let(:params) do
      {
        comment_id: 3
      }
    end

    let(:use_case) do
      instance_double(BlogApp::UseCases::DigComment, execute: {message: 'OK'})
    end

    before do
      allow(BlogApp::UseCases::DigComment).to receive(:new).and_return(use_case)

      login_user user
    end

    it 'executes the dig-comment use-case with the comment' do
      call
      expect(use_case).to have_received(:execute).with({comment_id: '3', user_id: user.id})
    end
  end

  describe 'POST /' do
    subject(:call) do
      post :create, params: params
    end

    let(:params) do
      {
        user_id: user.id,
        commentable_id: '3',
        commentable_type: 'Post',
        body: 'here is a fake message body.',
      }
    end

    let(:result) { BlogApp::Entities::Comment.new(params) }
    let(:use_case) do
      instance_double(BlogApp::UseCases::AddComment, execute: result)
    end

    before do
      allow(BlogApp::UseCases::AddComment).to receive(:new).and_return(use_case)

      login_user user
    end

    it 'executes the add-comment use-case with the comment' do
      call
      expect(use_case).to have_received(:execute).with(BlogApp::Entities::Comment.new(params.merge!(user_id: user.id)))
    end

    it 'serializes and renders the response' do
      call

      expected = params.merge(created_at: nil, updated_at: nil, id: nil, user_id: user.id, is_followed: false)
      expect(Oj.load(response.body, symbol_keys: true)).to eq(expected)
    end
  end

  describe 'GET /' do
    subject(:call) do
      get :index
    end

    let(:comment_attrs) do
      {
        user_id: 1,
        commentable_id: 3,
        commentable_type: 'Post',
        body: 'here is a fake message body.',
      }
    end

    let(:result) { 2.times.map { BlogApp::Entities::Comment.new(comment_attrs) } }
    let(:use_case) do
      instance_double(BlogApp::UseCases::ListComments, execute: result)
    end

    before do
      allow(BlogApp::UseCases::ListComments).to receive(:new).and_return(use_case)
    end

    it 'executes the list-comments use-case' do
      call
      expect(use_case).to have_received(:execute)
    end

    it 'serializes and renders the response' do
      call

      expected_list = 2.times.map do
        comment_attrs.merge(created_at: nil, updated_at: nil, id: nil, is_followed: false)
      end
      expect(Oj.load(response.body, symbol_keys: true)).to eq(expected_list)
    end
  end
end
