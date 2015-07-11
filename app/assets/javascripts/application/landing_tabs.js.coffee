ready = ->

  $('.fill-in .tab').on 'click', ->
    $('.fill-in .tab').removeClass('active')
    $(this).addClass('active')

    $('.fill-in .tab-content').hide()

    if $('.fill-in .tab.hiw').hasClass('active')
      $('.tab-content.hiw').show()
    else if $('.fill-in .tab.rating').hasClass('active')
      $('.tab-content.rating').show()
    else if $('.fill-in .tab.pcmr').hasClass('active')
      $('.tab-content.pcmr').show()

$(document).ready(ready)
$(document).on('page:load', ready)