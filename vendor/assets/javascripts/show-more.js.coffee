ready = ->
	$ ->
		$(".show-more").click ->
		  $this = $(this)
		  $this.text (if $this.text() is "Show less adjectives" then "Show more adjectives..." else "Show less adjectives")
		  $(".text").toggleClass "show-more-height"
		  return

$(document).ready(ready)
$(document).on('page:load', ready)