ready = ->

  $('.fill-in .tab').on 'click', ->
    $('.fill-in .tab').removeClass('active')
    $(this).addClass('active')

    $('.fill-in .tab-content').hide()

    if $('.fill-in .tab.hiw').hasClass('active')
      $('.tab-content.hiw').show()
    else if $('.fill-in .tab.graphs').hasClass('active')
      $('.tab-content.graphs').show()

$(document).ready(ready)
$(document).on('page:load', ready)