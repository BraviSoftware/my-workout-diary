mwd.models.user = (function(){
  var User = function(dto) {
    var self = this;

    self.provider = dto.provider;
    self.id = dto.id;
    self.uid = dto.uid;
    self.oauth_token = dto.oauth_token;
    self.name = dto.name;
    self.username = dto.username;
    self.picture = dto.picture;

    if (/google/i.test(self.provider)) {
      self.picture = self.picture += '?sz=100';
    }
    
    return self;
  };


  return User;
});