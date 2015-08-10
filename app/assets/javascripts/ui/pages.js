$(document).ready(function(){
  $("#listings").imagesLoaded(function(){
    $("#listings").masonry({
      itemSelector: '.box',
      isFitWidth: true
    });
  });
});
