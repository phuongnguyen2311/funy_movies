class UsersController < ApplicationController
  def create
    if valid_user_params?
      user = User.find_for_authentication(email: user_params[:email])
      valid_auth = user && user&.valid_password?(user_params[:password])
      user = User.create(user_params) unless valid_auth
    end
    if user
      sign_in(user)
      flash[:success] = "You have been access successfully!"
    else
      flash[:error] = "Invalid email or password. Please try again!"
    end
    redirect_to root_path
  end
end
