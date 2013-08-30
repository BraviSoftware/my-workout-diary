mwd.services.activityType = (function(model){
  var all = function(){
    return $.Deferred(function (def) {
      $.get('/activity_types', function(data){
        def.resolve(mwd.common.util().mapListToModel(data, model));
      });
    }).promise();
  };

  // public
  return {
    all: all
  };
})