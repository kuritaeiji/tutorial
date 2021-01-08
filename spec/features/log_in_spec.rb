require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  let(:user) { create(:user) }

  scenario('ログイン') do
    log_in_in_feature(user)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_selector('a', text: 'プロフィール')
    expect(page).to have_selector('a', text: 'ログアウト')
    expect(page).not_to have_selector('a', text: 'ログイン')

    log_out_in_feature
    expect(current_path).to eq(root_path)
    expect(page).to have_selector('a', text: 'ログイン')
    expect(page).not_to have_selector('a', text: 'ログアウト')
  end
end