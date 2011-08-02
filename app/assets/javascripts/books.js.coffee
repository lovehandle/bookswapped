# Wicked effect.
$(window).ready () -> $("#book_search_keywords").show 'slide'

# Allows users to access AJAX history using the 'Back' button
$(window).bind "popstate", () -> $.getScript(location.href)

revertTo = (step) ->
  exceptions = ["#step_" + step]
  if step > 1
    i = 0
    while i < step
      exceptions.push("#step_" + i)
      i++
  exceptions = exceptions.join()
  steps = $(".step").not(exceptions)
  steps.find(".loading").hide()
  steps.hide()

showStep = (step) ->
  $("#step_" + step).show "slide"
  $("#step_" + step + " .loading").show()

selectBook = (book) ->
  $(book).find(".selected").show()
  $(book).addClass("active")
  $(book).find("form").submit()

hideInactiveBooks = () -> $("#books .book").not(".active").hide "blind"

clearBooks  = () -> $("#books").html  ""
clearOffers = () -> $("#offers").html ""

# Step 1: When the book search form is submitted
$ -> $("#book_search_form").live 'submit', () ->

  # Push AJAX state to history
  history.pushState(null, "", $(this).attr("action") + "?" + $(this).serialize())
  # Hide all later steps
  revertTo(1)

  # Clear search results
  clearBooks()

  # Show loading
  showStep(1)

# Step 1: User hovers over a book
$ -> $("#books > .book:not(.active)").live({
  mouseenter: () -> 
    $(this).find(".arrow").show()
  mouseleave: () -> 
    $(this).find(".arrow").hide()
  })


# Step 1: When user selects a book
$ -> $("#books > .book:not(.active)").live 'click', () ->

  # Select book
  selectBook(this)

  # Hide all non-selected books
  hideInactiveBooks()

  # Hide all later steps
  revertTo(2)

  # Clear offers
  clearOffers()
  
  # Show loading
  showStep(2)

# Step 3: User hovers over a book offer
$ -> $("#offers tr").live({
  mouseenter: () -> 
    $(this).find(".arrow").show()
  mouseleave: () -> 
    $(this).find(".arrow").hide()
  })

$ -> $("#offers tbody tr").live 'click', () -> 
  link = $(this).find("a")
  window.open(link.attr('href'), '_newtab')
