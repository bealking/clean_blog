require './lib/blog_app/entities/comment'

RSpec.describe BlogApp::Entities::Comment do
  describe '#initialize' do
    it 'accepts an attribute hash' do
      comment = described_class.new(user_id: 3, body: 'fake body text', commentable_type: 'Post', commentable_id: 1)
      expect(comment.user_id).to eq 3
      expect(comment.body).to eq 'fake body text'
      expect(comment.commentable_type).to eq 'Post'
      expect(comment.commentable_id).to eq 1
    end
  end

  describe '#to_h' do
    it 'returns a symbol-key hash with the attributes' do
      comment = described_class.new
      comment.user_id = 3
      comment.body = 'fake body text'
      comment.commentable_type = 'Post'
      comment.commentable_id = 1

      expect(comment.to_h)
        .to eq(
          user_id: 3,
          body: 'fake body text',
          commentable_id: 1,
          commentable_type: 'Post',
          created_at: nil,
          updated_at: nil,
          id: nil
        )
    end
  end

  describe '#==' do
    it 'evaluates equality' do
      equality =
        described_class.new(title: 'b', body: 'c') ==
          described_class.new(title: 'b', body: 'c')

      expect(equality).to eq(true)
    end

    it 'evaluates inequality' do
      equality =
        described_class.new(title: 'b', body: 'c') ==
          described_class.new(title: 'e', body: 'f')

      expect(equality).to eq(false)
    end
  end
end
