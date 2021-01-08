module LogInHelper
  def log_in_in_feature(user)
    visit(log_in_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    within('#session-form') do
      click_on('ログイン')
    end
  end

  def log_out_in_feature
    within('.navbar-nav') do
      click_on('ログアウト')
    end
  end
end