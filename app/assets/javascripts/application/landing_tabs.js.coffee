ready = ->

  $('.landing-bottom .tab').on 'click', ->
    $('.landing-bottom .tab').removeClass('active')
    $(this).addClass('active')

    $('.landing-bottom .tab-content').hide()

    if $('.landing-bottom .tab.hiw').hasClass('active')
      $('.tab-content.hiw').show()
    else if $('.landing-bottom .tab.rating').hasClass('active')
      $('.tab-content.rating').show()
    else if $('.landing-bottom .tab.pcmr').hasClass('active')
      $('.tab-content.pcmr').show()

$(document).ready(ready)
$(document).on('page:load', ready)