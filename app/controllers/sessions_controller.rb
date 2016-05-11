class SessionsController < ApplicationController
  def new
    redirect_to '/auth/spotify'
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: "You have been logged out."
  end
end
