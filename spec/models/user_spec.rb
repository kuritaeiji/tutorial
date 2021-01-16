require 'rails_helper'

RSpec.describe User, type: :model do
  # it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to validate_length_of(:name).is_at_most(50) }

  # it { is_expected.to validate_length_of(:email).is_at_most(255) }
  # it { is_expected.to validate_presence_of(:email) }

  # it { is_expected.to validate_presence_of(:password) }
  # it { is_expected.to validate_length_of(:password).is_at_least(6) }

  # it { is_expected.to have_many(:microposts).dependent(:destroy) }
  it { is_expected.to have_many(:active_relationships).class_name('Relationship').with_foreign_key('follower_id').dependent(:destroy) }
  it { is_expected.to have_many(:followings).through(:active_relationships).source(:followed) }

  it { is_expected.to have_many(:passive_relationships).class_name('Relationship').with_foreign_key('followed_id').dependent(:destroy) }
  it { is_expected.to have_many(:followers).through(:passive_relationships).source(:follower) }

  # it('メールアドレスは有効なメールアドレスを持つ') do
  #   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
  #     foo@bar_baz.com foo@bar+baz.com]
  #   invalid_addresses.each do |invalid_address|
  #     user = build(:user, email: invalid_address)
  #     user.valid?
  #     expect(user.errors.messages[:email][0]).to eq('is invalid')
  #   end
  # end

  # it('メールアドレスは一意である') do
  #   other_user = create(:user, email: 'test@test.com')
  #   user = build(:user, email: 'test@test.com')
  #   user.valid?
  #   expect(user.errors.messages[:email][0]).to eq('has already been taken')
  # end

  # it('ユーザーを保存する直前にメールアドレスを小文字化する') do
  #   user = create(:user, email: 'TEST@TEST.com')
  #   expect(user.reload.email).to eq('test@test.com')
  # end

  # it('digestとtokenの比較') do
  #   user = build(:user)
  #   user.activation_token = User.create_token
  #   user.activation_digest = User.digest(user.activation_token)
  #   expect(user.authenticated?(:activation, user.activation_token)).to eq(true)
  # end

  # it('ユーザーが作成された時認証メールを送信すること') do
  #   allow(UserMailer).to receive_message_chain(:account_activation, :deliver_now)
  #   user = create(:user)
  #   expect(UserMailer).to have_received(:account_activation).with(user)
  # end

  it('ユーザーがフォローする') do
    user = create(:user)
    other_user = create(:user)
    user.follow(other_user)
    expect(user.following?(other_user)).to eq(true)

    user.unfollow(other_user)
    expect(user.following?(other_user)).to eq(false)
  end
end
