module LogInHelperRequest
  def log_in_in_request(user)
    post('/log_in', params: { session: { email: user.email, password: user.password } })
  end
end