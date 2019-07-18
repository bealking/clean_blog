require './lib/blog_app/entities/post'

RSpec.describe BlogApp::Entities::Post do
  describe '#initialize' do
    it 'accepts an attribute hash' do
      post = described_class.new(user_id: 3, title: 'fake-title', body: 'fake body text')
      expect(post.title).to eq 'fake-title'
      expect(post.user_id).to eq 3
      expect(post.body).to eq 'fake body text'
    end
  end

  describe '#to_h' do
    it 'returns a symbol-key hash with the attributes' do
      post = described_class.new
      post.user_id = 3
      post.title = 'fake-title'
      post.body = 'fake body text'

      expect(post.to_h)
        .to eq(
          user_id: 3,
          title: 'fake-title',
          body: 'fake body text',
          follows_count: 0,
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
