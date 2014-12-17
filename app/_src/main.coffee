# Initialize Foundation
$(document).foundation();

# Player
class Player
  @_element: null
  @_interval: null
  @_first: null
  constructor: (element) ->
    # Set the element
    @_element = element
    # Store first song
    @_first = $($('tr.song', @_element)[0])
    # Set current song
    @_current = $($('tr.active', @_element)[0])
    # Setup controls
    @setup_controls()
  playing: ->
    if @_interval then true else false
  denying: ->
    $('.skip', @_element).length > 0
  setup_controls: ->
    $('.controls a', @_element).click((e) =>
      if @playing()
        @stop()
      else
        @next()
        @play()
      @update_controls()
      e.preventDefault()
      )
    $('.toggle-denied', @_element).click((e) =>
      if @denying()
        $('.skip', @_element).removeClass('skip')
      else
        $('.should-skip', @_element).addClass('skip')
        current = $($('tr.active', @_element)[0])
        if current.hasClass('skip')
          @skip()
      @update_controls()
      e.preventDefault()
      )
  update_controls: ->
    if @playing()
      $('.controls a').removeClass().addClass('pause')
      $('.controls i').removeClass('fa-play').addClass('fa-pause')
    else
      $('.controls a').removeClass().addClass('play')
      $('.controls i').removeClass('fa-pause').addClass('fa-play')

    if @denying()
      $('.toggle-denied', @_element).addClass('active')
      $('.toggle-denied', @_element).html('<i class="fa fa-toggle-on"></i> Skipping Enabled')
    else
      $('.toggle-denied', @_element).removeClass('active')
      $('.toggle-denied', @_element).html('<i class="fa fa-toggle-off"></i> Skipping Disabled')
  next: ->
    # Determine current
    current = $($('tr.active', @_element)[0])
    # Determine next item
    next = if current.next().length then current.next() else @_first
    # Remove the active class
    current.removeClass('active')    
    # Add active class to next song
    next.addClass('active')
    $('td:first-child i', next).removeClass().addClass('fa fa-play-circle-o')
    # If song should be skipped, skip it
    if next.hasClass('skip')
      @skip(next)
  skip: (song) ->
    # Set other icon
    $('td:first-child i', song).removeClass().addClass('fa fa-times')
    # Wait a moment then skip it
    callback = @next.bind(@) # Retain correct 'this'
    setTimeout(callback, 250);
  play: ->
    @stop()
    callback = @next.bind(@) # Retain correct 'this'
    @_interval = setInterval(callback, 2000);
    @update_controls()
  stop: ->
    clearInterval(@_interval)
    @_interval = null
    @update_controls()

player = new Player($('#player'))
player.play()

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
$('body').append('<div id="overlay"></div>');

$('a.download').on('click', (e) ->

  # Show overlay
  $('#download').addClass('active')
  $('#overlay').fadeIn();

  # Track event
  _gaq.push(['_trackEvent', 'Downloads', 'show_download_overlay', 'Show the download overlay'])

  # e.preventDefault()
  )
$('.close', '#download').on('click', (e) ->

  # Hide overlay
  $('#download').removeClass('active')
  $('#overlay').fadeOut();

  # Track event
  _gaq.push(['_trackEvent', 'Downloads', 'close_download_overlay', 'Close the download overlay'])  

  e.preventDefault()
  )

# Uservoice
$('.uservoice').uservoice()
