$(document).on "ajax:success", "form.rate-form", (e, data, status, xhr) ->
  if data
    $("div.rating").prepend("<div>"+data.author+" "+"<div id=stars>s</div>"+" "+data.text_review+"</div>").each(->
      $(this).find("#stars").raty(number:10).raty('score', data.rating)
 )
  

    return false
  else
    return false