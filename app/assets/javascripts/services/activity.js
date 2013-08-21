mwd.services.activity = (function(model){
  var all = function(year, month, day){
    return $.Deferred(function (def) {
      $.getJSON('/activities', { year: year, month: month, day: day }, function(data){
        def.resolve(mapToModel(data, model));
      });
    }).promise();
  };

  // public
  return {
    all: all
  };
})