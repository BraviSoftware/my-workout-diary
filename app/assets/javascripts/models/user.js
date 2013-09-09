mwd.models.user = (function(){
  var User = function(dto) {
    var self = this;

    self.id = dto.id;
    self.name = dto.name;
    self.username = dto.username;
    self.picture = "https://graph.facebook.com/" + self.username + "/picture?type=small";

    return self;
  }


  return User;
});