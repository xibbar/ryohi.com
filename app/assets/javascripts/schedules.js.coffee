# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init_datetimepciker = ->
  (->
    $(".form_datetime").datetimepicker
      locale: "ja"
      format: "YYYY-MM-DD"
      sideBySide: true
  )

$(document).ready ->
  init_datetimepciker()

$(document).on "ready page:load", init_datetimepciker()
