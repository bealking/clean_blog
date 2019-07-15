require './lib/blog_app/use_cases/list_comments'
require './lib/blog_app/entities/comment'
require './lib/blog_app/repos/comments_repo'

RSpec.describe BlogApp::UseCases::ListComments do
  subject(:use_case) do
    described_class.new(comments_repo: comments_repo)
  end

  let(:comment_list_response) { double('response') }
  let(:comments_repo) { instance_double(BlogApp::Repos::CommentsRepo, list: comment_list_response) }

  describe '#execute' do
    subject(:result) do
      use_case.execute({commentable_id: 3, commentable_type: 'Post', limit: 5})
    end

    it 'lists the posts using the posts repo' do
      result
      expect(comments_repo).to have_received(:list)
    end

    it 'returns the response' do
      expect(result).to eq(comment_list_response)
    end
  end
end
