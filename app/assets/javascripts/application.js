//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require jquery
//= require_tree ./public


$(function(){
  $("#email-notification-bar").on("ajax:success", "a[data-remote]", function(e, data){
    var badge = $(this).find('.badge');

    badge.attr('class', 'badge badge-' + (data.receive_email ? 'success' : 'important'));
    badge.text((data.receive_email ? 'Activated' : 'Deactivated') + ' - Email Notification');
  });

  $('a', '#email-notification-bar').tooltip({
    placement: 'left',
    title: "Click to switch it."
  });
})

// requirejs.config({
//   "baseUrl" : "../../assets/javascripts",
//   "paths" : {
//     "knockout": "vendor/assets/javascripts/knockout-2.3.0"
//   },
//   "shim" : {
//     "knockout": {
//       exports: "knockout"
//     }
//   }
// });

// define(['knockout'], function(ko, require) {
// 	//TODO: Configure and call dependencies
//   $(function() {
//     console.log(ko);
//   });
// });
