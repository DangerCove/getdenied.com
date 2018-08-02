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
    transformation: 200,
    grace: 320
  }
  _trigger_positions: {
    apply: { start: 0, stop: 0 },
    restore: { start: 0, stop: 0 }
  }
  constructor: (trigger_element) ->
    el = trigger_element
    topbar = @_elements.topbar

    @_trigger_positions.apply.start = el.offset().top - (@_space.grace + @_space.transformation)
    @_trigger_positions.apply.stop = el.offset().top - @_space.grace

    @_trigger_positions.restore.start = el.offset().top + (el.height() * 4/5)
    @_trigger_positions.restore.stop = el.offset().top + (el.height() * 4/5) + @_space.transformation

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

      apply_pos = @_trigger_positions.apply
      restore_pos = @_trigger_positions.restore

      if pos > apply_pos.start && pos < apply_pos.stop
        perc = (pos - apply_pos.start) / (apply_pos.stop - apply_pos.start)

        @_reset_classes()
        @_apply_colors(perc)

      else if pos > apply_pos.stop && pos < restore_pos.start
        @_apply_classes()
        @_reset_colors()

      else if pos > restore_pos.start && pos < restore_pos.stop
        perc = 1 - (pos - restore_pos.start) / (restore_pos.stop - restore_pos.start)

        @_reset_classes()
        @_apply_colors(perc)

      else
        @_reset_classes()
        @_reset_colors()

dark_mode = new DarkMode($('#dark-mode'))
$(window).load ->
  dark_mode.check()
