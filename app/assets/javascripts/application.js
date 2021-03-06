//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require knockout
//= require underscore-min
//= require toastr
//= require bootstrap-datepicker
//= require_self
//= require_directory ./common
//= require_directory ./models
//= require_directory ./services

/* Global Namespaces
--------------------*/
mwd = {
  models: {},
  viewModels: {},
  services: {},
  common: {}
};

/* Config Toastr
---------------*/
toastr.options = {
  "debug": false,
  "positionClass": "toast-bottom-right",
  "onclick": null,
  "fadeIn": 300,
  "fadeOut": 1000,
  "timeOut": 5000,
  "extendedTimeOut": 1000
}

$(function(){
  $('[data-toggle="tooltip"]').tooltip({container: 'body'});

  $("#email-notification-bar").on("ajax:success", "a[data-remote]", function(e, data){
    var badge = $(this).find('.badge');

    badge.attr('class', 'badge badge-' + (data.receive_email ? 'success' : 'important'));
    badge.text((data.receive_email ? 'Activated' : 'Deactivated') + ' - Email Notification');
  });

  $("#buttons-activities").on("ajax:success", 'a[data-btnajax="activity"]', function(e, data){
    $(this).addClass('disabled');
  });

  /* Column Highlight
  =============*/
  var allCells = $("td, th", "#user-activities");
  allCells.on("mouseover", function() {
      var el = $(this),
          pos = el.index();
          if (pos > 0) {
            allCells.filter(":nth-child(" + (pos+1) + ")").addClass("columnHighlight");
          };
    })
    .on("mouseout", function() {
      allCells.removeClass("columnHighlight");
    });
})