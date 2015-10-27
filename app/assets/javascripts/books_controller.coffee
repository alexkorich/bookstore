# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:success", "form.book", (e, data, status, xhr) ->
  if data.price?
    $(".total-price").html("$"+data.price.toFixed(2)+"("+data.quantity+")");
    console.log(data);
    return false
  else
    return false
$(document).ready(->
  $(".raty").raty({ number: 10, target:"#rating_rating",
  starOff : 'https://s3.amazonaws.com/bookstore-korich-assets/assets/star-off.png',
  starOn  : 'https://s3.amazonaws.com/bookstore-korich-assets/assets/star-on.png',

   targetType : 'score', targetKeep : true})



  )