ready = ->

  if $('.game-index .headers')[0]
    sticky = new Waypoint.Sticky({
      element: $('.game-index .headers')[0]
    })

$(document).ready(ready)
$(document).on('page:load', ready)