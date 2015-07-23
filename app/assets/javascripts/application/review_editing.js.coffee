ready = ->

  $('.toggle-button').on 'click', ->
    $(@).parents('.section').children().last().slideToggle()

    currentText = $.trim($(@).html())
    if currentText == "Hide"
      newText = "Show"
    else
      newText = "Hide"

    $(@).html(newText)

$(document).ready(ready)
$(document).on('page:load', ready)