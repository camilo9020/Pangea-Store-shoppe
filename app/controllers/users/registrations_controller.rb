class Users::RegistrationsController < Devise::RegistrationsController

  def sign_up_params
     params.require(:user).permit(:first_name, :last_name, :state, :city, :address, :email, :phone, :password, :password_confirmation)
  end
  
  def account_update_params
     params.require(:user).permit(:first_name, :last_name, :state, :city, :address, :phone, :current_password, :password, :password_confirmation)
  end

end