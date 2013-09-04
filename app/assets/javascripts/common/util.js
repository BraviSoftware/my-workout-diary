mwd.common.util = (function(model){

  function mapListToModel (items, modelType){
    var list = [];
    for(var i = 0; i < items.length; i++){
      list.push(mapItemToModel(items[i], modelType));
    };
    return list;
  }

  function mapItemToModel (item, modelType) {
    return new modelType(item);
  }

  function selectedDate (){
    var params = getSelectedOrganizationAndDateParams();
    return {
      month: params.month,
      day: params.day,
      year: params.year
    }
  }

  function getSelectedOrganizationAndDateParams(){
    var params = location.pathname.split('/');

    return {
      organization: params[1],
      year: parseInt(params[2], 10),
      month: parseInt(params[3], 10),
      day: parseInt(params[4], 10)
    }
  }
  
  return {
    mapListToModel: mapListToModel,
    mapItemToModel: mapItemToModel,
    selectedDate: selectedDate,
  }
});