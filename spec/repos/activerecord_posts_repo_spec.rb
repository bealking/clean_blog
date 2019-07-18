require 'rails_helper'
require './lib/blog_app/entities/post'
require './lib/blog_app/entities/user'

RSpec.describe ActiverecordPostsRepo do
  let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}

  describe '#create' do
    let(:domain_obj) { BlogApp::Entities::Post.new(user_id: user.id, title: 'a', body: 'b') }

    it 'puts a new post in the database' do
      subject.create(domain_obj)
      post = Post.last
      expect(post.user_id).to eq user.id
      expect(post.title).to eq 'a'
      expect(post.body).to eq 'b'
    end

    it 'returns the created post, with id and timestamps' do
      response = subject.create(domain_obj)
      post = Post.last
      expected_response = BlogApp::Entities::Post.new(
        user_id: domain_obj.user_id,
        title: domain_obj.title,
        body: domain_obj.body,
        id: post.id,
        follows_count: 0,
        created_at: post.created_at,
        updated_at: post.updated_at
      )
      expect(response).to eq(expected_response)
    end

    it 'returns errors when post is invalid' do
      domain_obj.title = nil
      response = subject.create(domain_obj)
      expect(response).to eq ['标题不能为空字符']
    end
  end

  describe '#list' do
    it 'returns a collection of all posts' do
      attrs_list = [
        {user_id: user.id, title: 'b', body: 'c'},
        {user_id: user.id, title: 'e', body: 'f'}
      ]

      attrs_list.each do |attrs|
        Post.create!(attrs)
      end

      actual_attrs_list = subject.list.map do |post|
        expect(post).to be_a(BlogApp::Entities::Post)
        post.to_h.slice(:user_id, :title, :body)
      end
      expect(actual_attrs_list).to contain_exactly(*attrs_list)
    end
  end

  describe '#find' do
    it 'returns the requested post' do
      post = Post.create!(user_id: user.id, title: 'a', body: 'b')
      response = subject.find(post.id)
      expected_response = BlogApp::Entities::Post.new(
        user_id: post.user_id,
        title: post.title,
        body: post.body,
        id: post.id,
        follows_count: 0,
        created_at: post.created_at,
        updated_at: post.updated_at
      )
      expect(response).to eq(expected_response)
    end

  end
end
