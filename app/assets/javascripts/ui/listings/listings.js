$(document).ready(function(){
  $("#tag").tagit({
    singleField: true,
    removeConfirmation: true,
    placeholderText: ""
  });

  $("#listings").imagesLoaded(function(){
    $("#listings").masonry({
      itemSelector: '.box',
      isFitWidth: true
    });
  });

  // Hack to remove double fields - FIX THIS
  if ($(".tagit").length > 1){
    $(".tagit").last().hide();
  }

  $("#type .panel,#location .panel").on('click', function() {
    $(this).children('input').prop('checked',true)
  });
});
