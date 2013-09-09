mwd.models.activity = (function(userModel, activityTypeModel){
  var Activity = function(dto) {
    var self = this;

    self.id = dto.id;
    self.date = dto.date;
    self.activity_type_id = dto.activity_type_id;
    self.user_id = dto.user_id;
  
    if(dto.user) {
      self.user_id = self.user_id || dto.user.id;
      self.user = new userModel(dto.user);
    }

    if(dto.activity_type) {
      self.activity_type_id = self.activity_type_id || dto.activity_type.id;
      self.activity_type = new activityTypeModel(dto.activity_type);
    }

    return self;
  }


  return Activity;
});