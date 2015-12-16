module ApplicationHelper
	def bestSellers
	Shoppe::Product.root.ordered.includes(:product_categories, :variants)[0,4]
	end


	def products_related
		Shoppe::Product.root.ordered.includes(:product_categories, :variants)[0,3]
	end

	
	def belongs_permalink(permalink,category_id,subcategory_id)
    if subcategory_id
      permalink==category_id || permalink==subcategory_id
    else
      permalink_parent_id = Shoppe::ProductCategory.ordered.where(:permalink => permalink).first!.parent_id
      permalink_parent = nil
      if permalink_parent_id
        permalink_parent = Shoppe::ProductCategory.ordered.where(:id => permalink_parent_id).first!.permalink 
      end
      permalink==category_id || permalink==subcategory_id || permalink_parent==category_id    
    end     
  end
  
  def parent_category(category)
    if category.parent_id
       parent_category(Shoppe::ProductCategory.ordered.where(:id => category.parent_id).first!)
    else
        category
    end
  end
  

end
