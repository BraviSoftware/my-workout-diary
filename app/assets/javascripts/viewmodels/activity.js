mwd.viewModels.activity = (
  function(serviceActivity, serviceActivityType, Activity, ActivityType, auth){
    var activityTypes = ko.observableArray(),
    activities = ko.observableArray([]),
    activitiesGroupedByUser = ko.observableArray([]);

    function save(item) {
      item.doneByCurrentUser() ? destroy(item) : create(item);
    }

    function create(item) {
      var activity = new Activity({ date: new Date(), activity_type_id: item.id });
      $.when(serviceActivity.create(activity))
      .done(function(data){
        item.activityId(data.id);
        activities.push(data);
        toastr.success('Successfully marked activity.');
      });
    }

    function destroy(item){
      $.when(serviceActivity.destroy(item.activityId()))
      .done(function(){
        item.activityId(null);
        toastr.success('Successfully unmarked activity.');
      });
    }

    function getActivityTypeByActivity(activity) {
      return auth.currentUserId() === activity.user.id && activityTypes()[activity.activity_type_id - 1]; // by index
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
        groupActivitiesByUser();
      });
    }

    function groupActivitiesByUser(){
      var groupsByUser = _.groupBy(activities(), function(activity){ return activity.user.id; });

      //map groups to bind the view correctely
      var groups = _.map(groupsByUser, function (group, key, list) {
          return {
              user_id: key,
              activities: group
          };
      });

      activitiesGroupedByUser(groups);
    }

    function removeActivity(item){
      if(activitiesGroupIds.indexOf(item.user_id) === -1){
        activitiesGroupIds.push(item.user_id);
        activitiesGroupedByUser.push(item);
      }
    }

    var vm = {
      activityTypes: activityTypes,
      activitiesGroupedByUser: activitiesGroupedByUser,
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