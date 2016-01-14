class Users::SessionsController < Devise::SessionsController

  def sign_in_params
     params.require(:user).permit(:email, :password)
  end

end