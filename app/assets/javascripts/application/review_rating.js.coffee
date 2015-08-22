ready = ->

  adjustScore = (arrow, adjustment) ->
    scoreBox = $(arrow).parent()

    currentScore = parseInt($(scoreBox.children('.score')[0]).html())

    if $($(arrow).siblings()[0]).hasClass('yellow')
      adjustment = adjustment * 2

    if $(arrow).hasClass('yellow')
      adjustment = 0 - adjustment
      $(arrow).removeClass('yellow')
    else
      $(arrow).addClass('yellow')

    newScore = currentScore + adjustment

    $(scoreBox.children('.score')[0]).html(newScore);

    $($(arrow).siblings()[0]).removeClass('yellow');

  upvote = ->
    adjustScore(@, 1)
  downvote = ->
    adjustScore(@, -1)

  $('.upvote').on 'click', upvote
  $('.downvote').on 'click', downvote

$(document).ready(ready)
$(document).on('page:load', ready)