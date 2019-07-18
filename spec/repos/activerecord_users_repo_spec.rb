require 'rails_helper'
require './lib/blog_app/entities/comment'
require './lib/blog_app/entities/user'
require './lib/blog_app/entities/post'

RSpec.describe ActiverecordUsersRepo do
  let(:user) { User.create(email: 'bealking@gmail.com', password: '123456')}
  let(:post) { Post.create(user_id: user.id, title: 'a', body: 'b')}

  describe '#dig' do
    let(:comment) { Comment.create(user_id: user.id, body: 'c', commentable_type: 'Post', commentable_id: post.id) }

    it 'puts a new follow in the database' do
      subject.dig user.id, comment.id
      follow = Follow.last
      expect(follow.follower_id).to eq user.id
      expect(follow.followable_id).to eq comment.id
      expect(follow.followable_type).to eq 'Comment'
      post.reload
      expect(post.follows_count).to eq 1
    end
  end
end
