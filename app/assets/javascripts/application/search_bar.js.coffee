ready = ->

  if($('.search-bar'))

    # Toggling display of advanced option
    advancedOptionsToggle = ->
      if $($('.buttons')[0]).parent().hasClass('advanced-shown')
        $('.advanced-button').html('Hide Advanced Options')
        $($('.buttons')[0]).parent().slideUp()
      else
        $('.advanced-button').html('Show Advanced Options')
        $($('.buttons')[0]).parent().slideDown()

      $($('.buttons')[0]).parent().toggleClass('advanced-shown')

    $('.advanced-button').on 'click', advancedOptionsToggle

    # Ranked button
    $('.search-bar .ranked .text').on 'click', ->
      if $('input.ranked_only.search').val() == 'true'
        $('input.ranked_only.search').val('false')
      else
        $('input.ranked_only.search').val('true')

      $('#search-button').click()

    # Genres dropdown
    $('.search-bar .genres .dropdown-item').on 'click', ->
      newGenre = $(@).html()

      if($(@).hasClass('cancel'))
        newGenre = ''

      $('input.genre.search').val(newGenre)
      $('#search-button').click()

    # Platforms dropdown
    $('.search-bar .platforms .dropdown-item').on 'click', ->
      newPlatform = $(@).html()

      if($(@).hasClass('cancel'))
        newPlatform = ''

      $('input.platform.search').val(newPlatform)
      $('#search-button').click()

    # Categories dropdown
    $('.search-bar .categories .dropdown-item').on 'click', ->
      newCategory = $(@).html()

      if($(@).hasClass('cancel'))
        newCategory = ''

      $('input.category.search').val(newCategory)
      $('#search-button').click()

    # Sorting dropdown
    $('.search-bar .search-bar-button.sort .text').on 'click', ->
      $('.sort_link.asc, .sort_link.desc')[0].click()

    $('.search-bar-button.sort .text').html($('.sort_link.asc, .sort_link.desc').html())

$(document).ready(ready)
$(document).on('page:load', ready)