class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      login user
    else
      flash.now[:danger] = t "asession.show.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end
end
