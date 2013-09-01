mwd.models.activity = (function(dto){
  var self = this;

  self.id = dto.id;
  self.date = dto.date;
  self.activity_type_id = dto.activity_type_id;
  self.user_id = dto.user_id;

  if(dto.user) {
    self.user_id = self.user_id || dto.user.id;

    self.user = {};
    self.user.id = dto.user.id;
    self.user.name = dto.user.name;
    self.user.username = dto.user.username;
    self.user.picture = "https://graph.facebook.com/" + self.user.username + "/picture?type=small"
  }

  if(dto.activity_type) {
    self.activity_type_id = dto.activity_type_id || dto.activity_type.id;

    self.activity_type = {};
    self.activity_type.id = dto.activity_type.id;
    self.activity_type.name = dto.activity_type.name;
  }

  return self;
});