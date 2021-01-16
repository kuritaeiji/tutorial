require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it { is_expected.to belong_to(:follower).class_name('User') }
  it { is_expected.to belong_to(:followed).class_name('User') }

  it { is_expected.to validate_presence_of(:follower_id) }
  it { is_expected.to validate_presence_of(:followed_id) }

  it('フォロワーIDとフォロイングIDの組み合わせは一意') do
    follower_user = create(:user)
    following_user = create(:user)
    follower_user.follow(following_user)
    relationship = follower_user.active_relationships.new(followed_id: following_user.id)
    relationship.valid?
    expect(relationship.errors[:follower_id][0]).to eq('')
  end
end
