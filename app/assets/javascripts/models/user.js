mwd.models.user = (function(){
  var User = function(dto) {
    var self = this;

    self.provider = dto.provider;
    self.id = dto.id;
    self.uid = dto.uid;
    self.name = dto.name;
    self.username = dto.username;
    if (self.provider === 'facebook') {
      self.picture = "https://graph.facebook.com/" + self.username + "/picture?type=small";
    } else {
      self.picture = "https://plus.google.com/s2/photos/profile/" + self.uid + "?sz=100";
    }
    return self;
  }


  return User;
});