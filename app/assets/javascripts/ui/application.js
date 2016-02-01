$(document).ready(function(){
  var notification = $("#notification");
  notification.after().click(function (e) {
    console.log("click", e.offsetX )
      if (e.offsetX >= ($("#notification").width() - 5)) {
        notification.hide();
      }
  });
});
