#= require jquery
#= require jquery_ujs

$ ->

  updateOrderItemsFromRemote = (data)-> 
    
    if data.status == 'complete'      
      if data.redirect?        
        $('div.cart-item').replaceWith('')
        $('span.cart-total-value').html('$0.00'); 
      else if data.items?        
        $('div.cart-body-elements').replaceWith(data.items)
    else if data.status == 'error'
      alert data.message
    
  #
  # Submit a link
  #
  ajaxLink = (successMethod)->
    $.ajax
      url: $(this).attr('href')
      type: $(this).data('method')
      dataType: 'json'
      success: successMethod
    false
    

  $('body').on 'click', 'div.cart-item a.ajax, .add-to-cart', -> ajaxLink.call(this, updateOrderItemsFromRemote)
  $('body').on 'click', 'a.verMas' , ->
      $('div.hideProduct#'+$(this)[0].id).toggleClass('hideProduct')      
     
