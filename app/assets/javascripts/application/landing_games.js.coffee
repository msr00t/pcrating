ready = ->

  setInterval((->
    $.each($('.index .game-box-holder').children(), (id, gameBox) ->
      toHide = $(gameBox)
      toShow = $(gameBox).next()

      if toHide.is(':visible')
        toHide.slideUp((->
          toHide.parent().append(toHide)
        ))
        toShow.slideDown()
        return false
    )
  ), 5000)

$(document).ready(ready)
$(document).on('page:load', ready)