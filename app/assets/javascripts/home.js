//= require modernizr-2.8.3.min
//= require jquery
//= require rails-ujs
//= require landing/SmoothScroll
//= require landing/popper.min
//= require landing/bootstrap.min
//= require landing/jquery.easing.1.3.min
//= require landing/jquery.sticky
//= require landing/owl.carousel.min
//= require landing/scrollspy.min
//= require landing/jquery.app

$(document).ready(function() {
  $("#sticky-nav").sticky({topSpacing: 0});

  $('.navbar-nav a').on('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
          scrollTop: $($anchor.attr('href')).offset().top - 0
      }, 1500, 'easeInOutExpo');
      event.preventDefault();
  });

  $(".navbar-nav").scrollspy({
      offset: 50
  });
})
