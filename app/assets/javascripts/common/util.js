mwd.common.util = (function(model){

  function mapListToModel (items, modelType){
    var list = [];
    for(var i = 0; i < items.length; i++){
      list.push(mapItemToModel(items[i], modelType));
    };
    // debugger;
    return list;
  }

  function mapItemToModel (item, modelType) {
    // debugger;
    return new modelType(item);
  }

  function selectedDate (){
    var params = getSelectedOrganizationAndDateParams();
    return {
      month: params.month,
      day: params.day,
      year: params.year,
      date: new Date(params.year, params.month - 1, params.day)
    }
  }

  function getSelectedOrganizationAndDateParams(){
    var params = location.pathname.split('/');

    var selected = {
      organization: params[1],
      year: parseInt(params[2], 10),
      month: parseInt(params[3], 10),
      day: parseInt(params[4], 10)
    };

    if(!selected.organization || !selected.year || !selected.month || !selected.day){
      return defaultOrganizationAndDateParams();
    }

    return selected;
  }

  function defaultOrganizationAndDateParams (){
    var date = new Date();
    return {
      organization: 'bravi-software',
      month: date.getMonth() + 1,
      day: date.getDate(),
      year: date.getFullYear()
    }
  }
  
  return {
    mapListToModel: mapListToModel,
    mapItemToModel: mapItemToModel,
    selectedDate: selectedDate,
  }
});