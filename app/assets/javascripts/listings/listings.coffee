# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('#tag').tagit
    singleField: true
    removeConfirmation: true
    placeholderText: ""
	$('#listings').imagesLoaded ->
		$('#listings').masonry
      itemSelector: '.box'
      isFitWidth: true

#Hack to remove double fields - FIX THIS
if $('.tagit').length 
  $('.tagit').last().hide()
