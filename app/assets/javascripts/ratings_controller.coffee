$(document).on "ajax:success", "form.rate-form", (e, data, status, xhr) ->
  if data
    $("div.rating").prepend("<div>"+data.author+" "+"<div id=stars>s</div>"+" "+data.text_review+"</div>").each(->
      $(this).find("#stars").raty(number:10, starOff : 'https://s3.amazonaws.com/bookstore-korich-assets/assets/star-off.png',
  starOn  : 'https://s3.amazonaws.com/bookstore-korich-assets/assets/star-on.png').raty('score', data.rating)
 )
  

    return false
  else
    return false