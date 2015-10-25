# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(->
 $("#useExistingCard_").click(->
  isDisabled = $("#useExistingCard_").prop('checked');
  console.log(isDisabled)
  if(!isDisabled) 
    $("form.card-creation input, select").removeAttr("disabled");
    $("form.card-selection input.btn,form.card-selection input:radio").prop('disabled', true)
  else 
      $("form.card-creation input, select").prop('disabled', true)
      $("form.card-selection input.btn,form.card-selection input:radio").removeAttr("disabled");
  );

 isDisabled = $("#useExistingCard_").prop('checked');
 if(!isDisabled) 
    $("form.card-creation input").removeAttr("disabled");
    $("form.card-selection input.btn, form.card-selection input:radio").prop('disabled', true)    
  else 
    $("form.card-creation input").prop('disabled', true)
    $("form.card-selection input.btn, form.card-selection input:radio").removeAttr("disabled");

  $("#useBilling_").click(->
    isHide= $("#useBilling_").prop('checked');
    console.log(isHide)
    if(!isHide)
      $("ul.shipping").show();
    else 
        $("ul.shipping").hide();
    );

 isHide = $("#useBilling_").prop('checked');
 if(isHide) 
  $("ul.shipping").hide(); 
  
)