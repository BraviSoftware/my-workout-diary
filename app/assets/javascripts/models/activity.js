mwd.models.activity = (function(dto){
  var self = this;

  self.id = dto.id;
  self.date = dto.date;
  self.activity_type_id = dto.activity_type_id;
  self.user_id = dto.user_id;

  return self;
});