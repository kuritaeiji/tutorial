require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  scenario('サイトのレイアウトが正確') do
    visit(root_path)

    expect(page).to have_link('ホーム')
    expect(page).to have_link('ヘルプ')
    expect(page).to have_link('About')
    expect(page).to have_link('Contact')
  end
end
