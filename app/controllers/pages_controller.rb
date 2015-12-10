class PagesController < ApplicationController
include ApplicationHelper 
  def home
  
  	@products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
  	@products = @products.group_by(&:product_category)
    @product_brands = Shoppe::ProductAttribute.all.where(:key => 'Marca').group_by(&:value)
    @bestSellers = bestSellers
  end

  def show
  	@product = Shoppe::Product.root.find_by_permalink(params[:permalink])
  end

  
end
