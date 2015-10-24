# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




$(document).on "ajax:success", "form.book", (e, data, status, xhr) ->
  if data.price?
    $(".total-price").html("$"+data.price.toFixed(2)+"("+data.quantity+")");
    $(".total-price-table").html("$"+data.price.toFixed(2));
    return false
  else
    return false


$(document).on "ajax:success", "a", (e, data, status, xhr) ->
  console.log("TTTT");
  $("tr[data-id="+data.id+"]").remove()
  $(".total-price").html("$"+data.price.toFixed(2)+"("+data.quantity+")");
  $(".total-price-table").html("$"+data.price.toFixed(2));