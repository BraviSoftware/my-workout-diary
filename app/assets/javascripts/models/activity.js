define([], function() {
  var activity = function(user_name, date, activity_type) {
    var self = this;
    self.user_name = user_name;
    self.activity_type = activity_type;
  };

  return activityModel;
});