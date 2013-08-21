mwd.viewModels.activity = (
  function(serviceActivity, serviceActivityType, Activity, ActivityType, auth){
    var activityTypes = ko.observableArray(),
    activities = ko.observableArray(),
    save = function(item) {

    },
    init = function(){
      // load activity types
      $.when(serviceActivityType.all()).done(activityTypes);

      // load activities
      $.when(serviceActivity.all(2013, 08, 03)).done(function(items){
        items.forEach(function(item){
          activities.push(item);
          
          // if(auth.isUserAuthenticated())
        });
      });
    };

    var vm = {
      activityTypes: activityTypes,
      activities: activities,
      save: save
    };

    init();

    return vm;
  });

// Apply binds
$(function(){
  ko.applyBindings(new mwd.viewModels.activity(
    new mwd.services.activity(mwd.models.activity),
    new mwd.services.activityType(mwd.models.activityType),
    mwd.models.activity,
    mwd.models.activityType,
    mwd.auth()
    )
  );
});