$(document).ready(function(){

  var slideout = new Slideout({
    'panel': document.getElementById('panel'),
    'menu': document.getElementById('mobile-menu'),
    'padding': 256,
    'side': 'right',
    'tolerance': 70
  });

  // Toggle button
  document.querySelector('.toggle-button').addEventListener('click', function() {
    slideout.toggle();
    $('#mobile-menu').toggle();
  });
});
