require 'rails_helper'

RSpec.describe Micropost, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }
  it { is_expected.to belong_to(:user) }

  let(:user) { create(:user) }
  it('デフォルトスコープが新しく作成された順') do
    micropost = create(:micropost, user: user, created_at: 1.day.ago)
    micropost2 = create(:micropost, user: user, created_at: 1.hour.ago)
    micropost3 = create(:micropost, user: user, created_at: 4.hour.ago)
    expect(Micropost.all).to eq([micropost2, micropost3, micropost])
  end
end
