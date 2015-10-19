# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on  "page:change", ->
 $("form").on "ajax:success", (e, data, status, xhr) ->
  if data.price?
    $(".total-price").html(data.price.toFixed(2)+"("+data.quantity+")");
    return false
  else
    return false