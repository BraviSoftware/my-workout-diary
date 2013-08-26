mwd.viewModels.activity = (
  function(serviceActivity, serviceActivityType, Activity, ActivityType, auth){
    var activityTypes = ko.observableArray(),
    activities = ko.observableArray();

    function save(item) {
      function create() {
        var activity = new Activity({ date: new Date(), activity_type_id: item.id });
        $.when(serviceActivity.create(activity))
        .done(function(data){
          item.activityId(data.id);
          toastr.success('Successfully marked activity.');
        });
      }

      function destroy(){
        $.when(serviceActivity.destroy(item.activityId()))
        .done(function(){
          item.activityId(null);
          toastr.success('Successfully unmarked activity.');
        });
      }
      
      item.doneByCurrentUser() ? destroy() : create();
    }

    function getActivityTypeByActivity(activity) {
      return auth.currentUserId() === activity.user_id && activityTypes()[activity.activity_type_id - 1]; // by index
    }
    
    function init(){
      // load activity types
      $.when(serviceActivityType.all()).done(activityTypes);

      // load activities
      $.when(serviceActivity.all(selectedDate().year, selectedDate().month, selectedDate().day)).done(function(items){
        items.forEach(function(item){
          activities.push(item);

          // mark activity
          var activityType = getActivityTypeByActivity(item);
          if(activityType) {
            activityType.activityId(item.id);
          }
        });
      });
    }

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