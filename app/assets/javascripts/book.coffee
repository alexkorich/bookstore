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