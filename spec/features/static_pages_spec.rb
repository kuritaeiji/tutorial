require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  scenario('正確なタイトルが表示されている') do
    visit('/static_pages/home')
    expect(page).to have_title('home | rails tutorial')

    visit('/static_pages/help')
    expect(page).to have_title('help | rails tutorial')
  end
end
