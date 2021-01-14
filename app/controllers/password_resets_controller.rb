class PasswordResetsController < ApplicationController
  before_action(:set_user, only: [:edit, :update])
  before_action(:valid_user, only: [:edit, :update])
  before_action(:check_expiration, only: [:edit, :update])

  def new #メールアドレス入力画面
  end

  def create # メール送信
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_token_and_digest
      @user.send_reset_email
      flash[:success] = 'パスワード再設定のためのメールを送信しました。'
      redirect_to(root_url)
    else
      flash[:danger] = 'メールアドレスが間違っています。'
      redirect_to(new_password_reset_path)
    end
  end

  def edit # パスワード再設定画面
  end

  def update # パスワード再設定
    if @user.update(password_params)
      flash[:success] = 'パスワードを再設定しました。'
      redirect_to(log_in_path)
    else
      render('edit')
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def valid_user
      unless @user || @user.activated? || @user.authenticated?(:reset, params[:reset_token])
        redirect_to(root_url)
      end
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def check_expiration
      unless @user.password_reset_expired?
        flash[:danger] = 'メールの期限切れです。'
        redirect_to(new_password_reset_url)
      end
    end
end
