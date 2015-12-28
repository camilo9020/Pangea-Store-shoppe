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
  
  def search(products,params)
     search_input = "%#{params[:search].gsub(/\s/,'%')}%"
     products.joins('LEFT OUTER JOIN "shoppe_product_category_translations" ON "shoppe_product_category_translations"."id" = "shoppe_product_categories"."id" 
     LEFT OUTER JOIN "shoppe_product_category_translations" "shoppe_product_category_translations_parent" ON "shoppe_product_category_translations_parent"."id" = "shoppe_product_categories"."parent_id" 
     ').where('"shoppe_product_translations"."name" LIKE ? OR
      "shoppe_products"."sku" LIKE ? OR 
      "shoppe_product_translations"."permalink" LIKE ? OR 
      "shoppe_product_category_translations"."name" LIKE ? OR 
      "shoppe_product_category_translations_parent"."name" LIKE ?',search_input,search_input,search_input,search_input,search_input)
  end
  
  def filterCategory(products,params)
     
     products.joins('LEFT OUTER JOIN "shoppe_product_category_translations" ON "shoppe_product_category_translations"."id" = "shoppe_product_categories"."id" 
     LEFT OUTER JOIN "shoppe_product_category_translations" "shoppe_product_category_translations_parent" ON "shoppe_product_category_translations_parent"."id" = "shoppe_product_categories"."parent_id" 
     ')
     .where('shoppe_product_category_translations.name IN (:categories) OR shoppe_product_category_translations_parent.name IN (:categories)',{categories: params[:categories]})

  end
  def filterBrands(products,params)
      products.joins('LEFT OUTER JOIN "shoppe_product_attributes" ON "shoppe_product_attributes"."product_id" = "shoppe_products"."id"')
      .where('shoppe_product_attributes.value IN (:brands) AND shoppe_product_attributes.key == "Marca"',{brands: params[:brands]})  
  end
  
  def filterPrice(products,params)
      products.where('(shoppe_products.price BETWEEN :min AND :max AND variants_shoppe_products.price IS NULL ) OR (variants_shoppe_products.price BETWEEN :min AND :max ) ',{min: params[:minPrice] , max: params[:maxPrice]})  
  end

end

  
  
  

