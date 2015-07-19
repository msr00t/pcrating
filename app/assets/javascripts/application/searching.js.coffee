ready = ->

  if($('.search-bar'))
    $('.search-bar .ranked .text').on 'click', ->
      if $('input.ranked_only.search').val() == 'true'
        $('input.ranked_only.search').val('false')
      else
        $('input.ranked_only.search').val('true')

      $('#search-button').click()

    $('.search-bar .genres .dropdown-item').on 'click', ->
      newGenre = $(@).html()

      if($(@).hasClass('cancel'))
        newGenre = ''

      $('input.genre.search').val(newGenre)
      $('#search-button').click()

    $('.search-bar .platforms .dropdown-item').on 'click', ->
      newPlatform = $(@).html()

      if($(@).hasClass('cancel'))
        newPlatform = ''

      $('input.platform.search').val(newPlatform)
      $('#search-button').click()

    $('.search-bar .search-bar-button.sort .text').on 'click', ->
      $('.sort_link.asc, .sort_link.desc')[0].click()

    $('.search-bar-button.sort .text').html($('.sort_link.asc, .sort_link.desc').html())

$(document).ready(ready)
$(document).on('page:load', ready)