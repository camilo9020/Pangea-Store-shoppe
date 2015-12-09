#= require jquery
#= require jquery_ujs

$ ->

  updateOrderItemsFromRemote = (data)->
    if data.status == 'complete'      
      if data.redirect?
        window.location.replace(data.redirect)
      else if data.items?        
        $('div.cart-items').replaceWith(data.items)
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
    

  $('body').on 'click', 'div.cart-item a.ajax', -> ajaxLink.call(this, updateOrderItemsFromRemote)

