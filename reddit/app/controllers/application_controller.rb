class ApplicationController < ActionController::Base

  helper_method :login! , :current_user , :logged_in?

  def login!(user)
    @current_user = user
    session[:session_token] = user.ensure_token
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logout!
    current_user.reset_token
    session[:session_token] = nil
  end

end
