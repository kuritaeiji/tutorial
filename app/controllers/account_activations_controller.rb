class AccountActivationsController < ApplicationController
  def activate
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
      user.update(activated: true)
      log_in(user)
      flash[:success] = 'アカウントを有効化しました'
      redirect_to(user)
    else
      flash[:danger] = '無効なリンクです'
      redirect_to(root_url)
    end
  end
end