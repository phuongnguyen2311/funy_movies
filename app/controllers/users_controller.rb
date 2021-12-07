class UsersController < ApplicationController
  def create
    user = User.find_for_authentication(email: user_params[:email])
    valid_auth = user && user&.valid_password?(user_params[:password])
    user = User.create(user_params) unless valid_auth
    
    if user
      sign_in(user)
      flash[:success] = "You have been access successfully!"
    else
      flash[:error] = "Invalid email or password. Please try again!"
    end
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
