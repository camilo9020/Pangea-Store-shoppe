class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  
  protected

  def configure_permitted_parameters
    
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :email, :password, :password_confirmation) }

  end
  
  private
  
  def parent_categories  
	  @categories = Shoppe::ProductCategory.where(:depth => 0)
	end
  
  def subcategories(parent_id)
    @subcategories = Shoppe::ProductCategory.where(:parent_id => parent_id)
  end

  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Shoppe::Order.create(:ip_address => request.ip)
        session[:order_id] = order.id
        order
      end
    end
  end

  def has_order?
    !!(
      session[:order_id] &&
      @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
    )
  end

  helper_method :current_order, :has_order? , :parent_categories , :subcategories
  
end
