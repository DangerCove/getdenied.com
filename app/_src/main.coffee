# Some comment

class Player
  @_interval: null
  @_first: null
  constructor: ->
    # Store first song
    @_first = $($('#player tr.song')[0])
    # Set current song
    @_current = $($('#player tr.active')[0])
  next: ->
    # Determine current
    current = $($('#player tr.active')[0])
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
  stop: =>
    clearInterval(@_interval)

player = new Player
player.play()