# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  uservoice: (options) ->
    # Default settings
    settings =
      debug: true

    # Merge default settings with options.
    settings = $.extend settings, options

    # Save element
    element = $(@)

    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug

    # Ignore click
    ignore = (e) ->
      e.preventDefault()

    # _Insert magic here._
    return @each ()->
      topics = []
      $.ajax({
        url: '//dangercove.uservoice.com/api/v1/topics/62350/articles.json?client=8KiWIaX9jEbsnUu7TDLQWg&per_page=100',
        dataType: 'jsonp',
        success: (data) ->
          $('.loading', element).hide()
          $.each(data.articles, (i, article) ->
            article_item = document.createElement 'li'
            $(article_item).attr 'class', 'article_' + article.id
            article_title = document.createElement 'h3'
            $(article_title).text article.question
            $(article_title).appendTo article_item
            $(article_title).click((e) ->
              if($(this).siblings('.answer').is(":visible"))
                _gaq.push(['_trackEvent', 'Support', 'close_article_' + article.id, 'Close: ' + article.question])
              else
                _gaq.push(['_trackEvent', 'Support', 'open_article_' + article.id, 'Open: ' + article.question])
              $(this).siblings('.answer').toggle()
            )
            article_answer = document.createElement 'div'
            $(article_answer).attr 'class', 'answer'
            $(article_answer).html article.answer_html
            $(article_answer).hide()
            $(article_answer).appendTo article_item

            $(article_item).appendTo element
          )
      })
