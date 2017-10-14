require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :nickname }
  it { is_expected.to validate_length_of(:nickname).is_at_most(39) }

  describe 'unique validation for nickname' do
    subject { create :user }
    it { is_expected.to validate_uniqueness_of(:nickname).ignoring_case_sensitivity }
  end

  describe '#nickname_downcase' do
    let!(:user_1) { create :user, nickname: 'nickname' }
    let!(:user_2) { build :user, nickname: 'Nickname' }

    specify do
      expect(user_2).to_not be_valid
    end
  end
end
