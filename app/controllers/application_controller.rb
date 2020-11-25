class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "log_in.danger"
    redirect_to login_path
  end

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or root_path
  end

  def check_login
    return if logged_in?

    flash[:warning] = t "message.pls_login"
    redirect_to login_path
  end
end
