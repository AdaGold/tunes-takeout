class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_from_omniauth(auth_hash)

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "did not login in"
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end
