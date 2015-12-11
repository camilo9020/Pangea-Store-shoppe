module ApplicationHelper
	def bestSellers
	Shoppe::Product.root.ordered.includes(:product_categories, :variants)[0,4]
	end

	def products_related
		Shoppe::Product.root.ordered.includes(:product_categories, :variants)[0,3]
	end



end
