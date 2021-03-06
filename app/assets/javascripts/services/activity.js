mwd.services.activity = (function(model){
  var serviceUrl = '/activities';

  function all(year, month, day){
    return $.Deferred(function (def) {
      $.getJSON(serviceUrl, { year: year, month: month, day: day })
      .done(function(data){
        def.resolve(mwd.common.util().mapListToModel(data, model));
      })
      .fail(function(jqxhr, textStatus, error){
        def.reject(textStatus + ", " + error);
      });
    }).promise();
  }
  
  function create(activity){
    return $.Deferred(function (def) {
      $.post(serviceUrl, { activity: activity }).done(function(data){
        def.resolve(mwd.common.util().mapItemToModel(data, model));
      })
      .fail(function(jqxhr, textStatus, error){
        def.reject(textStatus + ", " + error);
      });
    }).promise();
  }

  function destroy(id){
    return $.ajax({ url: serviceUrl + '/' + id, type: 'DELETE' });
  }

  return {
    all: all,
    create: create,
    destroy: destroy
  };
})