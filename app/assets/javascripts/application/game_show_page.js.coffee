ready = ->

  if($('.main-game-info'))
    mainGameInfoHeight = $('.main-game-info').height()
    $('.requirements').css({ "max-height": mainGameInfoHeight + 'px' });

$(document).ready(ready)
$(document).on('page:load', ready)