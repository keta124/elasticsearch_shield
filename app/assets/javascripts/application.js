// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require adminto/modernizr.min
//= require jquery
//= require rails-ujs
//= require adminto/popper.min
//= require adminto/bootstrap.min
//= require adminto/waves
//= require adminto/wow.min
//= require adminto/jquery.slimscroll

//= require bootstrap-select.min
//= require icheck
//= require live_coin_price

//= require datatables/jquery.dataTables.min
//= require datatables/dataTables.bootstrap4.min
//= require datatables/dataTables.buttons.min
//= require datatables/buttons.bootstrap4.min
//= require datatables/jszip.min
//= require datatables/pdfmake.min
//= require datatables/vfs_fonts
//= require datatables/buttons.html5.min
//= require datatables/buttons.print.min
//= require datatables/dataTables.responsive.min
//= require datatables/responsive.bootstrap4.min

//= require adminto/jquery.core

$(document).ready(function() {
  $('.navbar-toggle').on('click', function (event) {
    $(this).toggleClass('open');
    $('#navigation').slideToggle(400);
  });

  $('.navigation-menu>li').slice(-2).addClass('last-elements');

  $('.navigation-menu li.has-submenu a[href="#"]').on('click', function (e) {
    if ($(window).width() < 992) {
      e.preventDefault();
      $(this).parent('li').toggleClass('open').find('.submenu:first').toggleClass('open');
    }
  });

  $('.slimscroll').slimscroll({
    height: 'auto',
    position: 'right',
    size: "8px",
    color: '#9ea5ab'
  });

  $(".navigation-menu a").each(function () {
    if (this.href == window.location.href) {
      $(this).parent().addClass("active"); // add active to li of the current link
      $(this).parent().parent().parent().addClass("active"); // add active class to an anchor
      $(this).parent().parent().parent().parent().parent().addClass("active"); // add active class to an anchor
    }
  });

  $(".right-bar-toggle").click(function () {
    $(".right-bar").toggle();
    $('.wrapper').toggleClass('right-bar-enabled');
  });
})
