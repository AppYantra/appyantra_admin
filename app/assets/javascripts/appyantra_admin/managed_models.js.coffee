# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ = jQuery
$.fn.highlightItem = (item_id) ->
  $('.highlight_item').toggleClass('highlight_item');
  $('#model_item_' + item_id).toggleClass('highlight_item');