//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require knockout
//= require underscore-min
//= require_self
//= require_directory ./utils
//= require_directory ./models
//= require_directory ./services
//= require ./viewmodels/activity

// Global Namespaces
mwd = {
  models: {},
  viewModels: {},
  services: {},
  auth: function(){
    var currentUserId = function (){
      return parseInt($('#user').data('id'), 10);
    },

    isUserAuthenticated = function(){
      return currentUserId() && currentUserId() > 0;
    };

    var vm = {
      currentUserId: currentUserId,
      isUserAuthenticated: isUserAuthenticated
    };

    return vm;
  }
};

var mapToModel = function (items, modelType){
  var list = [];
  for(var i = 0; i < items.length; i++){
    list.push(mapItemToModel(items[i], modelType));
  };
  return list;
}
var mapItemToModel = function (item, modelType) {
  return new modelType(item);
}

$(function(){
  $('a[data-toggle="tooltip"]').tooltip({container: 'body'});

  $("#email-notification-bar").on("ajax:success", "a[data-remote]", function(e, data){
    var badge = $(this).find('.badge');

    badge.attr('class', 'badge badge-' + (data.receive_email ? 'success' : 'important'));
    badge.text((data.receive_email ? 'Activated' : 'Deactivated') + ' - Email Notification');
  });

  $("#buttons-activities").on("ajax:success", 'a[data-btnajax="activity"]', function(e, data){
    $(this).addClass('disabled');
  });
})