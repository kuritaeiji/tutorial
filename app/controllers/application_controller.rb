class ApplicationController < ActionController::Base
  protect_from_forgery(with: :exception)
  include(SessionsHelper)

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインして下さい'
        redirect_to(log_in_url)
      end
    end

    def correct_user
      unless current_user == User.find(params[:id])
        flash[:danger] = '正しいユーザーではありません'
        redirect_to(root_url)
      end
    end
end
