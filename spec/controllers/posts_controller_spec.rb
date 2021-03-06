require 'rails_helper'

require './lib/blog_app/entities/post'
require './lib/blog_app/use_cases/add_post'
require './lib/blog_app/use_cases/list_posts'

RSpec.describe PostsController do
  describe 'POST /' do
    subject(:call) do
      post :create, params: params
    end

    let(:params) do
      {
        user_id: user.id,
        title: 'fake title',
        body: 'here is a fake message body.',
      }
    end

    let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}
    let(:result) { BlogApp::Entities::Post.new(params) }
    let(:use_case) do
      instance_double(BlogApp::UseCases::AddPost, execute: result)
    end

    before do
      allow(BlogApp::UseCases::AddPost).to receive(:new).and_return(use_case)

      login_user user
    end

    it 'executes the add-post use-case with the post' do
      call
      expect(use_case).to have_received(:execute).with(BlogApp::Entities::Post.new(params.merge!(user_id: user.id)))
    end

    it 'serializes and renders the response' do
      call

      expected = params.merge(created_at: nil, updated_at: nil, id: nil, user_id: user.id, follows_count: 0)
      expect(Oj.load(response.body, symbol_keys: true)).to eq(expected)
    end
  end

  describe 'GET /' do
    subject(:call) do
      get :index
    end

    let(:post_attrs) do
      {
        user_id: 3,
        title: 'fake title',
        body: 'here is a fake message body.',
      }
    end

    let(:result) { 2.times.map { BlogApp::Entities::Post.new(post_attrs) } }
    let(:use_case) do
      instance_double(BlogApp::UseCases::ListPosts, execute: result)
    end

    before do
      allow(BlogApp::UseCases::ListPosts).to receive(:new).and_return(use_case)
    end

    it 'executes the list-posts use-case' do
      call
      expect(use_case).to have_received(:execute)
    end

    it 'serializes and renders the response' do
      call

      expected_list = 2.times.map do
        post_attrs.merge(created_at: nil, updated_at: nil, id: nil, follows_count: 0)
      end
      expect(Oj.load(response.body, symbol_keys: true)).to eq(expected_list)
    end
  end
end
