require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to have_many(:comments) }

  describe '#recent' do
    let!(:post_1) { create :post }
    let!(:post_2) { create :post }

    it 'should order courses by created_at DESC' do
      expect(Post.recent).to eq [post_2, post_1]
    end
  end

  describe '#time_now_if_published_at_is_nil' do
    let!(:published_at) { '10.10.2016' }

    context 'when published_at is present' do
      let!(:post) { create :post, published_at: Time.parse(published_at) }

      specify do
        expect(Post.last.published_at).to eq Time.parse(published_at)
      end
    end

    context 'when published_at is blank' do
      before { allow(Time).to receive(:now).and_return(Time.parse(published_at)) }

      let!(:comment) { create :comment, published_at: '' }

      specify do
        expect(Post.last.published_at).to eq Time.parse(published_at)
      end
    end
  end
end
