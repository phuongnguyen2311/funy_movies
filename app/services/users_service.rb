class UsersService
  def initialize(params)
    @params = params
  end

  def execute
    valid = true
    user = User.find_for_authentication(email: params[:email])
    if user
      valid = false unless user && user&.valid_password?(params[:password])
    else
      user = User.create(params)
      valid = false if user.errors.full_messages.present?
    end
    [valid, user]
  end

  private

  attr_reader :params
end
