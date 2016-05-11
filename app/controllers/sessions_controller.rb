class SessionsController < ApplicationController
  def new
    redirect_to '/auth/spotify'
  end

  def create
    self.current_user = User.find_or_create_by_auth_hash(auth_hash)
    if self.current_user
      redirect_to root_path, notice: "You have been logged in."
    else
      redirect_to sign_in_users_path, notice: "Unable to log in."
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: "You have been logged out."
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
