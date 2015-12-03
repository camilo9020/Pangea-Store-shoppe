module ApplicationHelper
	def bestSellers
	Shoppe::Product.root.ordered.includes(:product_categories, :variants)[0,4]
	end
end
