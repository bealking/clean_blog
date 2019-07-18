require './lib/blog_app/use_cases/add_comment'
require './lib/blog_app/use_cases/list_comments'
require './lib/blog_app/entities/post'
require './lib/blog_app/entities/comment'
require './lib/blog_app/repos/posts_repo'
require './lib/blog_app/repos/comments_repo'

RSpec.describe BlogApp::UseCases::AddComment do
  subject(:use_case) do
    described_class.new(comments_repo: comments_repo)
  end

  let(:comment_create_response) { double('response') }
  let(:comments_repo) { instance_double(BlogApp::Repos::CommentsRepo, create: comment_create_response) }

  describe '#execute' do
    subject(:result) do
      use_case.execute(comment)
    end

    let(:comment) do
      BlogApp::Entities::Comment.new
    end

    it 'adds the post to the posts repo' do
      result
      expect(comments_repo).to have_received(:create).with(comment)
    end

    it 'returns the response' do
      expect(result).to eq(comment_create_response)
    end
  end
end
