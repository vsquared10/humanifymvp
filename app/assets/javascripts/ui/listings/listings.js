$('#tag').tagit({
  singleField: true,
  removeConfirmation: true,
  placeholderText: ""
});

$('#listings').imagesLoaded(function(){
  $('#listings').masonry({
    itemSelector: '.box',
    isFitWidth: true
  });
});

// Hack to remove double fields - FIX THIS
if $('.tagit').length{
  $('.tagit').last().hide();
}
