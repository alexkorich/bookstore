$(document).on "ajax:success", "form.rate-form", (e, data, status, xhr) ->
  if data
    $("div.rating").prepend("<div>"+data.author+" "+data.rating+" "+data.text_review+"</div>");
    return false
  else
    return false