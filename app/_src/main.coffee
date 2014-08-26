# Some comment

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
  update_controls: ->
    if @playing()
      $('.controls a').removeClass().addClass('pause')
      $('.controls i').removeClass('fa-play').addClass('fa-pause')
    else
      $('.controls a').removeClass().addClass('play')
      $('.controls i').removeClass('fa-pause').addClass('fa-play')
  next: ->
    # Determine current
    current = $($('tr.active', @_element)[0])
    # Determine next item
    next = if current.next().length then current.next() else @_first
    # Remove the active class
    current.removeClass('active')    
    # Add active class to next song
    next.addClass('active')
    # If song should be skipped, skip it
    if next.hasClass('skip')
      @skip()
  skip: ->
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