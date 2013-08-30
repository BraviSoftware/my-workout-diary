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
    var date = new Date();
    return {
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