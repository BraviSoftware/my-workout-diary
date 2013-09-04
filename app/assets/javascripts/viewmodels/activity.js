mwd.viewModels.activity = (
  function(serviceActivity, serviceActivityType, Activity, ActivityType, auth, util){
    var activityTypes = ko.observableArray(),
    activities = ko.observableArray([]),
    activitiesGroupedByUser = ko.observableArray([]),
    activityTypesLoadCompleted = ko.observable(false);

    function save(activityType) {
      activityType.doneByCurrentUser() ? destroy(activityType) : create(activityType);
    }

    function create(activityType) {
      var activity = new Activity({ date: new Date(), activity_type_id: activityType.id });
      $.when(serviceActivity.create(activity))
      .done(function(activity){
        addActivity(activityType, activity);
        toastr.success('Successfully marked activity.');
      });
    }

    function destroy(activityType){
      $.when(serviceActivity.destroy(activityType.activityId()))
      .done(function(){
        removeActivity(activityType);
        toastr.success('Successfully unmarked activity.');
      });
    }

    function getActivityTypeByActivity(activity) {
      return auth.currentUserId() === activity.user.id && activityTypes()[activity.activity_type.id - 1]; // by index
    }

    function loadActivityTypes(){
      $.when(serviceActivityType.all()).done(activityTypes).then(function(){ activityTypesLoadCompleted(true) });
    }

    function loadActivities(){
      var date = util.selectedDate();
      $.when(serviceActivity.all(date.year, date.month, date.day)).done(function(items){
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
              activities: ko.observableArray(group)
          };
      });

      activitiesGroupedByUser(groups);
    }

    function removeActivity(activityType){
      activityType.activityId(null);

      var group = findGroupByCurrentUser();
      if(group){
        // remove activity
        group.activities.remove(function(activity){ return activity.activity_type.id == activityType.id; });

        // remove group
        if(group.activities().length === 0) {
          activitiesGroupedByUser.remove(function(user){ return isUserGroup(user); });
        }
      }
    }

    function findGroupByCurrentUser(){
      return _.find(activitiesGroupedByUser(), function(user) { return isUserGroup(user); });
    }

    function addActivity(activityType, activity) {
      activityType.activityId(activity.id);

      var group = findGroupByCurrentUser();
      if (group) {
        group.activities.push(activity);
        return;
      }

      // create new user group
      group = {
            user_id: auth.currentUserId(),
            activities: ko.observableArray([activity])
        };
      activitiesGroupedByUser.push(group);
    }

    function isUserGroup(user){
      return parseInt(user.user_id, 10) === auth.currentUserId(); 
    }

    var vm = {
      activityTypes: activityTypes,
      activitiesGroupedByUser: activitiesGroupedByUser,
      save: save,
      isUserLoggedIn: auth.isUserAuthenticated(),
      activityTypesLoadCompleted: activityTypesLoadCompleted
    };

    (function init(){
      loadActivityTypes();
      loadActivities();
    }());

    return vm;
  });

// Apply binds
$(function(){
  ko.applyBindings(new mwd.viewModels.activity(
    new mwd.services.activity(mwd.models.activity),
    new mwd.services.activityType(mwd.models.activityType),
    mwd.models.activity,
    mwd.models.activityType,
    mwd.common.authentication(),
    mwd.common.util()
    )
  );
});