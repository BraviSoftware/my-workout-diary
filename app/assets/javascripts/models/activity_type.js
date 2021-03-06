mwd.models.activityType = (function() {
  var ActivityType = function(dto) {
    var self = this;
    
    var build_image_path = function(id){
      var images = { 
        '1' : 'runner.png', 
        '2' : 'water.png', 
        '3' : 'fruits.png' 
      };

      return '/assets/' + images[id];
    };

    // properties
    self.id = dto.id || 0;
    self.name = dto.name || ''; 
    self.description = dto.description || '';
    self.image = build_image_path(dto.id);

    // extend
    self.activityId = ko.observable(dto.activityId);
    self.doneByCurrentUser = function(){
      return self.activityId() > 0;
    }
    self.activated = ko.computed(function(){
      return self.activityId();
    }); 


    return self;
  }

  return ActivityType;
});