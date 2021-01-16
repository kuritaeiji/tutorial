class UsersController < ApplicationController
  before_action(:logged_in_user, only: [:edit, :update, :index, :show, :destroy, :followings, :followers])
  before_action(:correct_user, only: [:edit, :update])
  before_action(:admin_user, only: [:destroy])

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      remember(@user)
      flash[:success] = 'メールをチェックしてアカウントを有効化してください'
      redirect_to(@user)
    else
      render('new')
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to(@user)
    else
      render('edit')
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to(users_url)
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    render('show_follow')
  end

  def followings
    @title = 'フォローユーザー'
    @user = User.find(params[:id])
    @users = @user.followings.paginate(page: params[:page], per_page: 10)
    render('show_follow')
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(request.original_url || root_url) unless current_user.admin
    end
end
