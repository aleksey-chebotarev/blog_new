require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to belong_to(:commentable) }

  describe '#time_now_if_published_at_is_nil' do
    let!(:published_at) { '10.10.2016' }

    context 'when published_at is present' do
      let!(:comment) { create :comment, published_at: Time.parse(published_at) }

      specify do
        expect(Comment.last.published_at).to eq Time.parse(published_at)
      end
    end

    context 'when published_at is blank' do
      before { allow(Time).to receive(:now).and_return(Time.parse(published_at)) }

      let!(:comment) { create :comment, published_at: '' }

      specify do
        expect(Comment.last.published_at).to eq Time.parse(published_at)
      end
    end
  end
end
