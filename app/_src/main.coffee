# Initialize Foundation
$(document).foundation()

# Listen to scrolling
class TopMenu
  @_element = null
  constructor: (element) ->
    @_element = element
  check: (element) ->
    el_y = element.offset().top + element.outerHeight()
    $(window).scroll (e) =>
      if $(window).scrollTop() > el_y
        @_element.addClass('scrolled')
      else
        @_element.removeClass('scrolled')

top_menu = new TopMenu($('#topbar'))
top_menu.check($('#header'))

# Downloads

# Add overlay
$('body').append('<div id="overlay"></div>')

$('a.buy').on('click', (e) ->

  # Track event
  _gaq.push(['_trackEvent', 'Buy', 'goto_app_store', 'Go to the Mac App Store'])
)

$('a.download').on('click', (e) ->

  # Show overlay
  $('#download').addClass('active')
  $('#overlay').fadeIn()

  # Track event
  _gaq.push(['_trackEvent', 'Downloads', 'show_download_overlay', 'Show the download overlay'])

  # e.preventDefault()
  )
$('.close', '#download').on('click', (e) ->

  # Hide overlay
  $('#download').removeClass('active')
  $('#overlay').fadeOut()

  # Track event
  _gaq.push(['_trackEvent', 'Downloads', 'close_download_overlay', 'Close the download overlay'])

  e.preventDefault()
  )

# Dark Mode
$(window).scroll (e) =>
  el = $("#dark-mode")
  topbar = $("#topbar")
  pos = $(window).scrollTop()

  trigger_pos = el.offset().top - 320
  end_trigger_pos = el.offset().top + el.height() + topbar.height()

  console.log end_trigger_pos

  if pos > trigger_pos && pos < end_trigger_pos
    el.addClass("dark-mode")
    topbar.addClass("dark-mode")
  else
    el.removeClass("dark-mode")
    topbar.removeClass("dark-mode")
