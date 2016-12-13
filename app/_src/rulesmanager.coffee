# Rules manager
if $('.rules-manager').length > 0
  
  # Handle file selected
  $('.rules-manager__file').on('change', (e) ->
    console.log('file selected')
  )
  # Forward action from button to file input
  $('.rules-manager__load').on('click', (e) ->
    $('.rules-manager__file').click()
  )
