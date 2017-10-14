require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to belong_to(:author).class_name('User') }

  describe '#time_now_if_published_at_is_nil' do
    let(:time_now) { Time.now.change(usec: 0) }

    specify do
      allow(Time).to receive(:now).and_return(time_now)

      post = create :post, published_at: ''

      expect(post.published_at).to eq Time.now
    end
  end
end
