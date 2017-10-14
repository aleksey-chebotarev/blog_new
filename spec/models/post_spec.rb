require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to belong_to(:author).class_name('User') }

  describe '#recent' do
    let!(:post_1) { create :post }
    let!(:post_2) { create :post }

    it 'should order courses by created_at DESC' do
      expect(Post.recent).to eq [post_2, post_1]
    end
  end

  describe '#time_now_if_published_at_is_nil' do
    let(:time_now) { Time.now.change(usec: 0) }

    specify do
      allow(Time).to receive(:now).and_return(time_now)

      post = create :post, published_at: ''

      expect(post.published_at).to eq Time.now
    end
  end
end
