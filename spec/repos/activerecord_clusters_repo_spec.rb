require 'rails_helper'
require './lib/blog_app/entities/user'
require './lib/blog_app/entities/comment'

RSpec.describe ActiverecordClustersRepo do
  let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}
  let(:person) { User.create(email: 'beal@21cn.com', password: '123456')}

  describe '#search' do
    before do
      post_attrs_list = [
        {user_id: user.id, title: 'b', body: 'c', follows_count: 10},
        {user_id: person.id, title: 'e', body: 'f'}
      ]

      post_attrs_list.each do |attrs|
        Post.create!(attrs)
      end

      article_attrs_list = [
        {user_id: person.id, title: 'b', body: 'c', follows_count: 4},
        {user_id: user.id, title: 'e', body: 'f'}
      ]

      article_attrs_list.each do |attrs|
        Article.create!(attrs)
      end

      Post.reindex
      Article.reindex
    end

    it 'with non-filter params' do
      result = subject.search
      expect(result.size).to eq 4
    end

    it 'with follows_count greater than limit param' do
      result = subject.search({follows_count: {gt: 3}})
      expect(result.size).to eq 2
      expect(result.collect{|object| object.follows_count}).to eq [10, 4]
    end

    it 'with user email eq limit param' do
      comment = Comment.create(commentable_id: Article.last.id, commentable_type: 'Article', body: 'g', user_id: user.id)
      Follow.create(follower_id: user.id, follower_type: 'User', followable_id: comment.id, followable_type: 'Comment')
      result = subject.search({user_email: 'bealking@gmail.com'})
      expect(result.size).to eq 1
      expect(result.collect{|object| object.id}).to eq [Article.last.id]
    end

  end
end
