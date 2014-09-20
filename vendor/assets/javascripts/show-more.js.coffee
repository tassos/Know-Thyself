$ ->
	$(".show-more").click ->
	  $this = $(this)
	  $this.text (if $this.text() is "Show Less Adjectives" then "Show more adjectives..." else "Show less adjectives")
	  $(".text").toggleClass "show-more-height"
	  return
