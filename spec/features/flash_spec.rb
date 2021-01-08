require 'rails_helper'

RSpec.feature "Flashes", type: :feature do
  scenario('フラッシュメッセージのテスト') do
    visit(log_in_path)
    within('#session-form') do
      click_on('ログイン')
    end

    expect(page).to have_selector('.alert.alert-danger', text: 'メールアドレスまたはパスワードが違います。')
    visit(root_path)
    expect(page).not_to have_selector('.alert.alert-danger', text: 'メールアドレスまたはパスワードが違います。')
  end
end
