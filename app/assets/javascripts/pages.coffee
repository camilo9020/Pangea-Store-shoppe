#= require jquery
#= require jquery_ujs

$ ->

  updateOrderItemsFromRemote = (data)-> 
    
    if data.status == 'complete'
      console.log(data)  
      if data.items == undefined         
        $('div.cart-item').replaceWith('');
        $('div.checkout-order-items').replaceWith('');   
        $('div.checkout_delivery_service').replaceWith(''); 
        $('div.checkout-total-value').html('$0.00');      
        $('span.cart-total-value').html('$0.00'); 
      else if data.items?        
        $('div.cart-body-elements').replaceWith(data.items)
        $('div.your-order').replaceWith(data.items_checkout)
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
     
