$(document).ready(function(){
  $("#notification").after().click(function (e) {
      if (e.offsetX >= ($("#notification").width() - 5)) {
        $("#notification").hide();
      }
  });
});
