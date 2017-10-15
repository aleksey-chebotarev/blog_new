require 'rails_helper'

describe ApplicationHelper do
  describe '#build_report' do
    context 'should to check the sorting' do
      let(:user_1) { create :user }
      let(:user_2) { create :user }

      let!(:posts) { create_list :post, 2, author: user_1, published_at: '10.12.2015' }
      let!(:post)  { create :post, author: user_2, published_at: '10.12.2015' }

      specify do
        expect(helper.build_report('10.10.2015', '10.10.2016')).to eq [user_1, user_2]
      end
    end
  end
end
