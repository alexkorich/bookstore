# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(->
  $(".owl-carousel").owlCarousel(

      navigation : true,
      navigationText: ["<i class='icon-chevron-left icon-white'></i>",
      "<i class='icon-chevron-right icon-white'></i>"
      ],
      slideSpeed : 900,
      paginationSpeed : 900,
      singleItem:true);
  )