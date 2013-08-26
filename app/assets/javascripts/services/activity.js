mwd.services.activity = (function(model){
  var serviceUrl = '/activities';

  function all(year, month, day){
    return $.Deferred(function (def) {
      $.getJSON(serviceUrl, { year: year, month: month, day: day }, function(data){
        def.resolve(mapToModel(data, model));
      });
    }).promise();
  }
  
  function create(activity){    
    return $.post(serviceUrl, { activity: activity });
  }

  function destroy(id){
    return $.ajax({ url: serviceUrl + '/' + id, type: 'DELETE' });
  }

  // public
  return {
    all: all,
    create: create,
    destroy: destroy
  };
})