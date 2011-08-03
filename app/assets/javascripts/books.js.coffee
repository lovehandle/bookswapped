# Wicked effect.
$(window).ready () -> $("#book_search_keywords").show 'slide'

# Allows users to access AJAX history using the 'Back' button
$(window).bind "popstate", () -> $.getScript(location.href)

@scrollTo = (id) -> $('html,body').animate({scrollTop: $(id).offset().top }, 'slow')

@replaceNullImages = () -> $("img.book_image").each () -> 
  if this.height == this.width
    $(this).addClass 'no_image'
    $(this).attr 'src', '/assets/no_image.jpeg'

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

getOffers = (ean) -> $("#offers").load("/books/" + ean + "/offers", () -> toStep3())

selectBook = (book) ->
  $(book).find(".selected").show()
  $(book).addClass("active")
  hideInactiveBooks()  

  ean = $(book).find("#ean").val()
  getOffers(ean)


hideInactiveBooks = () -> $("#books .book").not(".active").hide('blind').remove()

clearBooks  = () -> $("#books").html  ""
clearOffers = () -> $("#offers").html ""

# Step 1: When the book search form is submitted
$ -> $("#book_search_form").submit () ->

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

  # Hide all later steps
  revertTo(2)

  # Clear offers
  clearOffers()
  
  # Show loading
  showStep(2)

# Step 2: Comparing prices
@toStep3 = () ->
  $("#step_2_loading").hide()
  $("#step_2 #completed").show()
  showStep(3)
  scrollTo("#step_3")

# Step 3: User hovers over a book offer
$ -> $("#offers tr").live({
  mouseenter: () -> 
    $(this).find(".arrow").show()
  mouseleave: () -> 
    $(this).find(".arrow").hide()
  })

# Step 3: User selects a book offer
$ -> $("#offers tbody tr").live 'click', () -> 
  link = $(this).find("a")
  window.open(link.attr('href'), '_newtab')
