class UsersController < ApplicationController
  def create
    valid, user = UsersService.new(user_params).execute
    if valid && user
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
