class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(to: @user.email, subject: 'アカウント有効化')
  end
end
