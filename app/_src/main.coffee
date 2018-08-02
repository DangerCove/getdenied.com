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
  el = $('#dark-mode')
  topbar = $('#topbar')
  body = $('body')
  all = $('*:not(a)')
  banded = $('.banded')

  pos = $(window).scrollTop()
  transformation_space = 480
  grace_space = 320

  r = { background: { start: 255, end: 7 }, text: { start: 51, end: 255 }, secondary: { start: 238, end: 11 } }
  g = { background: { start: 255, end: 15 }, text: { start: 51, end: 255 }, secondary: { start: 238, end: 24 } }
  b = { background: { start: 255, end: 36 }, text: { start: 51, end: 255 }, secondary: { start: 238, end: 57 } }

  start_trigger_pos = el.offset().top - transformation_space
  stop_trigger_pos = el.offset().top - grace_space
  end_trigger_pos = el.offset().top + (el.height() / 5 * 4) + topbar.height()

  if pos > start_trigger_pos && pos < stop_trigger_pos
    perc = (pos - start_trigger_pos) / (stop_trigger_pos - start_trigger_pos)

    r_bg = Math.round(r.background.start - ((r.background.start - r.background.end) * perc))
    g_bg = Math.round(g.background.start - ((g.background.start - g.background.end) * perc))
    b_bg = Math.round(b.background.start - ((b.background.start - b.background.end) * perc))

    r_txt = Math.round(r.text.start - ((r.text.start - r.text.end) * perc))
    g_txt = Math.round(g.text.start - ((g.text.start - g.text.end) * perc))
    b_txt = Math.round(b.text.start - ((b.text.start - b.text.end) * perc))

    r_scnd = Math.round(r.secondary.start - ((r.secondary.start - r.secondary.end) * perc))
    g_scnd = Math.round(g.secondary.start - ((g.secondary.start - g.secondary.end) * perc))
    b_scnd = Math.round(b.secondary.start - ((b.secondary.start - b.secondary.end) * perc))

    body.css('background-color', 'rgb(' + r_bg + ',' + g_bg + ',' + b_bg + ')')
    banded.css('background-color', 'rgb(' + r_bg + ',' + g_bg + ',' + b_bg + ')')
    topbar.css('background-color', 'rgb(' + r_bg + ',' + g_bg + ',' + b_bg + ')')
    all.css('color', 'rgb(' + r_txt + ',' + g_txt + ',' + b_txt + ')')
    all.css('border-color', 'rgb(' + r_scnd + ',' + g_scnd + ',' + b_scnd + ')')
  else if pos > stop_trigger_pos
    body.addClass('dark-mode')
    topbar.addClass('dark-mode')

    body.css('background-color', '')
    banded.css('background-color', '')
    topbar.css('background-color', '')
    all.css('color', '')
    all.css('border-color', '')
  else
    body.removeClass('dark-mode')
    topbar.removeClass('dark-mode')

    body.css('background-color', '')
    banded.css('background-color', '')
    topbar.css('background-color', '')
    all.css('color', '')
    all.css('border-color', '')
