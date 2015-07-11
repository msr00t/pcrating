ready = ->

  hideRequirements = ->
    $('.requirements .buttons img').removeClass('active')
    $('.requirements .buttons a').removeClass('active')
    $('.requirements .buttons a.minimum').addClass('active')
    $('.requirements .platform').hide()
    $('.requirements .platform').children().hide()
    $('.level-link').hide()
    $('.hide-requirements').hide()

  requirementsToggle = ->
    # If we're clicking a link that is already active and it's a platform,
    # hide the requirements
    if $(@).hasClass('active')
      if $(@).hasClass('platform-link')
        hideRequirements()
      else
        return
    else
      if $(@).prop("tagName") != undefined
        $('.hide-requirements').show()
        $('.level-link').show()
        if $(@).hasClass('platform-link')
          $('.requirements .buttons .platform-link').removeClass('active')
        else
          $('.requirements .buttons .level-link').removeClass('active')

      $(@).addClass('active')

    platform = $('.requirements .buttons .platform-link.active').data('platform')
    level = $('.requirements .buttons .level-link.active').data('level')

    $('.requirements .platform').hide()
    $('.requirements .platform').children().hide()

    $('.requirements .' + platform).show(0, ->
      $('.requirements .' + platform + ' .' + level).show(100)
    )

  if $('.requirements.buttons')
    $('.requirements .buttons a, .requirements .buttons img').on 'click', requirementsToggle
    requirementsToggle()
    $('.requirements .hide-requirements').on 'click', hideRequirements

$(document).ready(ready)
$(document).on('page:load', ready)