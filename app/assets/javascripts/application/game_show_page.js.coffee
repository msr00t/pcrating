ready = ->

  if($('.main-game-info'))
    mainGameInfoHeight = $('.main-game-info').height()
    $('.requirements').css({ "max-height": mainGameInfoHeight + 'px' });

    $('.review .show-details-button').on 'click', ->
      review = $(@).parents('.review')
      stats = $(review).find('.stats')

      stats.toggle()

      if $(stats).is(':visible')
        $(@).html('Hide Details')
      else
        $(@).html('Show Details')

$(document).ready(ready)
$(document).on('page:load', ready)