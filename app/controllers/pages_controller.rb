class PagesController < ApplicationController
include ApplicationHelper 
  def home    
  	@products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
    @all_products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
    if params[:search] 
       @products = search(@products,params)
    end
    
    if params[:categories] 
       @products = filterCategory(@products,params)
    end
    
    if params[:brands] 
       @products = filterBrands(@products,params)
    end
    
    if params[:minPrice] ||  params[:maxPrice]
       @products = filterPrice(@products,params)
    end
    
  	@products = @products.group_by { |p| parent_category(p.product_category) }
    @all_products = @all_products.group_by { |p| parent_category(p.product_category) }
    
    @product_brands = Shoppe::ProductAttribute.all.where(:key => 'Marca').group_by(&:value)
    @bestSellers = bestSellers
  end

  def show
  	@product = Shoppe::Product.root.find_by_permalink(params[:permalink])
  end

  
end
