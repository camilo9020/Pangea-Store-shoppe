#= require jquery
#= require jquery_ujs

$ ->

  updateOrderItemsFromRemote = (data)-> 
    
    if data.status == 'complete'        
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
  $('#price-filter-amount').on 'change', ->      
      $('#minPrice').val($('#price-filter-amount').text().split('-')[0].replace('$','').trim())
      $('#maxPrice').val($('#price-filter-amount').text().split('-')[1].replace('$','').trim())
  $('#minPrice').val(getUrlParameter('minPrice')||0)
  $('#maxPrice').val(getUrlParameter('maxPrice')||10000)   
     
