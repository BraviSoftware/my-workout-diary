define([], function() {
  function activityTypeModel = function(id, name) {
    var self = this;
    
    self.id = id || '';
    self.name = name || ''; 
  };

  return activityTypeModel;
});