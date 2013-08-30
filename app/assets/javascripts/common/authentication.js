mwd.common.authentication = (function(model){
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
});