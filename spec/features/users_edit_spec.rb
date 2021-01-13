require 'rails_helper'

RSpec.feature "UsersEdits", type: :feature do
  let(:user) { create(:user) }

  scenario('無効な値を入力するとエラーメッセージが表示される') do
    log_in_in_feature(user)
    visit(edit_user_path(user))
    fill_in('Email', with: '')
    click_on('更新')

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_selector('.alert.alert-danger')
    expect(page).to have_selector('li', text: "Email can't be blank")
  end

  scenario('有効な値を入力するとユーザーが更新される') do
    log_in_in_feature(user)
    visit(edit_user_path(user))

    fill_in('Email', with: 'test@test.com')
    fill_in('Name', with: 'test')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_on('更新')

    expect(user.reload.email).to eq('test@test.com')
    expect(user.name).to eq('test')
    expect(current_path).to eq(user_path(user))
    expect(page).to have_selector('.alert.alert-success', text: 'ユーザー情報を更新しました')
  end

  scenario('フレンドリーフォワーディング') do
    visit(edit_user_path(user))
    expect(current_path).to eq(log_in_path)

    log_in_in_feature(user)
    expect(current_path).to eq(edit_user_path(user))
  end
end
