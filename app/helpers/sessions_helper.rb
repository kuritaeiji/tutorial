module SessionsHelper
  def log_in(user)
    session_id = SecureRandom.base64(24)
    session[:id] = session_id
    user.update(session_id: session_id)
  end

  def log_out
    session.delete(:id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(session_id: session[:id]) if session[:id]
  end

  def logged_in?
    !!current_user
  end
end
