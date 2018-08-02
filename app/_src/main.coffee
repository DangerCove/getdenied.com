# Initialize Foundation
$(document).foundation()

# Listen to scrolling
class TopMenu
  constructor: (@_element) ->
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
class DarkMode
  _elements: {
    body: $('body'),
    topbar: $('#topbar'),
    all: $('*:not(a)'),
    banded: $('.banded')
  }
  _colors: {
    background: { r: { start: 255, end: 7 }, g: { start: 255, end: 15 }, b: { start: 255, end: 36 } }
    text: { r: { start: 51, end: 255 }, g: { start: 51, end: 255 }, b: { start: 51, end: 255 } }
    secondary: { r: { start: 238, end: 11 }, g: { start: 238, end: 24 }, b: { start: 238, end: 57 } }
  }
  _space: {
    transformation: 480,
    grace: 320
  }
  _trigger_positions: {
    start: 0,
    stop: 0,
  }
  constructor: (trigger_element) ->
    el = trigger_element
    topbar = @_elements.topbar

    @_trigger_positions.start = el.offset().top - @_space.transformation
    @_trigger_positions.stop = el.offset().top - @_space.grace

  _color_value: (color, percentage) ->
    Math.round(color.start - ((color.start - color.end) * percentage))

  _apply: (color, element, property, percentage) ->

    r = @_color_value(color.r, percentage)
    g = @_color_value(color.g, percentage)
    b = @_color_value(color.b, percentage)
    
    element.css(property, 'rgb(' + r + ',' + g + ',' + b + ')')

  _apply_colors: (percentage) ->
    els = @_elements

    @_apply(@_colors.background, els.body, 'background-color', percentage)
    @_apply(@_colors.background, els.banded, 'background-color', percentage)
    @_apply(@_colors.background, els.topbar, 'background-color', percentage)
    @_apply(@_colors.text, els.all, 'color', percentage)
    @_apply(@_colors.secondary, els.all, 'border-color', percentage)

  _apply_classes: ->
    els = @_elements

    els.body.addClass('dark-mode')
    els.topbar.addClass('dark-mode')

  _reset: (element, property) ->
    element.css(property, '')

  _reset_colors: ->
    els = @_elements

    @_reset(els.body, 'background-color')
    @_reset(els.banded, 'background-color')
    @_reset(els.topbar, 'background-color')
    @_reset(els.all, 'color')
    @_reset(els.all, 'border-color')

  _reset_classes: ->
    els = @_elements

    els.body.removeClass('dark-mode')
    els.topbar.removeClass('dark-mode')

  check: ->
    $(window).scroll (e) =>

      pos = $(window).scrollTop()
      start_trigger_pos = @_trigger_positions.start
      stop_trigger_pos = @_trigger_positions.stop

      if pos > start_trigger_pos && pos < stop_trigger_pos
        perc = (pos - start_trigger_pos) / (stop_trigger_pos - start_trigger_pos)

        @_apply_colors(perc)

      else if pos > stop_trigger_pos
        @_apply_classes()
        @_reset_colors()

      else
        @_reset_classes()
        @_reset_colors()

dark_mode = new DarkMode($('#dark-mode'))
dark_mode.check()
