module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies[:remember_token] = { value: user.remember_token, expired: 20.years.from_now }
    cookies.signed[:user_id] = { value: user.id, expired: 20.years.from_now }
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_digest)
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif user_id = cookies.signed[:user_id]
      if user = User.find_by(id: user_id) && user.authenticated?(:remember ,cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(default_url)
    target_url = session[:forwarding_url] || default_url
    session.delete(:forwarding_url)
    redirect_to(target_url)
  end
end
