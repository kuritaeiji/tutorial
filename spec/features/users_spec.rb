require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario('新規登録画面で不正な値を入力する') do
    visit(sign_up_path)
    expect { click_on('登録') }.not_to change(User, :count)

    expect(page).to have_selector('.alert.alert-danger', text: '個のエラーがあります')
    expect(current_path).to eq(sign_up_path)
  end

  scenario('新規登録画面からユーザー登録する') do
    visit(sign_up_path)
    valid_params = attributes_for(:user) 
    expect {
      fill_in('Email', with: valid_params[:email])
      fill_in('Name', with: valid_params[:name])
      fill_in('Password', with: valid_params[:password])
      fill_in('Password confirmation', with: valid_params[:password_confirmation])
      click_on('登録')
    }.to change(User, :count).by(1)

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_selector('.alert.alert-success', text: 'ようこそ、サンプルアプリへ')
  end
end
