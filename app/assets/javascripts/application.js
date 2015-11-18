// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require version
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require jquery_ujs


//= require bootstrap.js
// require plugins/input-mask/jquery.inputmask.js
// require plugins/input-mask/jquery.inputmask.date.extensions.js
// require plugins/input-mask/jquery.inputmask.extensions.js
// require plugins/raphael/raphael-min.js
//= require plugins/morris/morris.js
//= require plugins/sparkline/jquery.sparkline.js
//= require plugins/jvectormap/jquery-jvectormap-1.2.2.min.js
//= require plugins/jvectormap/jquery-jvectormap-world-mill-en.js
//= require plugins/knob/jquery.knob.js
// require plugins/daterangepicker/daterangepicker.js
// require plugins/datepicker/bootstrap-datepicker.js
// require plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js
//= require plugins/iCheck/icheck.min.js
//= require plugins/slimScroll/jquery.slimscroll.min.js
//= require plugins/fastclick/fastclick.min.js
//= require plugins/dist/js/app.js

//= require snackbar.js
//= require turbolinks
//= require comments

$(document).on('page:change', function () {
  Turbolinks.enableProgressBar();
  
  if($('.snackbar-message').length > 0){
    $('.snackbar-message').snackbar('show');
  };

  $("[data-controlsidebar]").on('click', function () {
    change_layout($(this).data('controlsidebar'));
    var slide = !AdminLTE.options.controlSidebarOptions.slide;
    AdminLTE.options.controlSidebarOptions.slide = slide;
    if (!slide){
      $('.control-sidebar').removeClass('control-sidebar-open');
    };
  });
});