require 'rails_helper'
require './lib/blog_app/entities/comment'
require './lib/blog_app/entities/user'
require './lib/blog_app/entities/post'

RSpec.describe ActiverecordCommentsRepo do
  let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}
  let(:post) { Post.create(user_id: user.id, title: 'a', body: 'b')}

  describe '#create' do
    let(:domain_obj) { BlogApp::Entities::Comment.new(user_id: user.id, body: 'c', commentable_type: 'Post', commentable_id: post.id) }

    it 'puts a new comment in the database' do
      subject.create(domain_obj)
      comment = Comment.last
      expect(comment.user_id).to eq user.id
      expect(comment.body).to eq 'c'
      expect(comment.commentable_id).to eq post.id
      expect(comment.commentable_type).to eq 'Post'
    end

    it 'returns the created comment, with id and timestamps' do
      response = subject.create(domain_obj)
      comment = Comment.last
      expected_response = BlogApp::Entities::Comment.new(
        user_id: domain_obj.user_id,
        body: domain_obj.body,
        id: comment.id,
        commentable_type: 'Post',
        commentable_id: post.id,
        created_at: comment.created_at,
        updated_at: comment.updated_at
      )
      expect(response).to eq(expected_response)
    end
  end

  describe '#list' do
    it 'returns a collection of all comments' do
      another_post = Post.create(user_id: user.id, title: 'f', body: 'g')
      post_attrs_list = [
        {user_id: user.id, body: 'c', commentable_type: 'Post', commentable_id: post.id},
        {user_id: user.id, body: 'd', commentable_type: 'Post', commentable_id: post.id},
      ]

      attrs_list = post_attrs_list | [{user_id: user.id, body: 'e', commentable_type: 'Post', commentable_id: another_post.id}]
      attrs_list.each do |attrs|
        Comment.create!(attrs)
      end

      actual_attrs_list = subject.list({commentable_id: post.id, commentable_type: 'Post'}).map do |comment|
        expect(comment).to be_a(BlogApp::Entities::Comment)
        comment.to_h.slice(:user_id, :commentable_id, :commentable_type, :body)
      end
      expect(actual_attrs_list).to contain_exactly(*post_attrs_list)
    end
  end
end
