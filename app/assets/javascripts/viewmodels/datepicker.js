mwd.viewModels.datepicker = (function(){
  var fullDatepicker;
  function pad2(num) {
    var s = "0" + num;
    return s.substr(s.length-2);
  }

  function rewriteUrlWithSelectedDate(url, selectedDate){
    var month = selectedDate.getMonth(), 
          year = selectedDate.getFullYear(),
          day = selectedDate.getDate();
    // remove previous day
    if (fullDatepicker) { url = removeDatePart(url); };
    // remove previous month
    url = removeDatePart(url);
    // remove previous year
    url = removeDatePart(url);
    // new url
    url += '/' + year + '/' + pad2(month + 1);
    if (fullDatepicker) { url += '/' + pad2(day); };
    return url;
  }

  function removeDatePart(url){
    return url.substring(0, url.lastIndexOf('/'));
  }

  function redirectToNewMonth(selectedDate, viewMode){
    fullDatepicker = false;
    if (viewMode === 'months') {
      window.location = rewriteUrlWithSelectedDate(window.location.pathname, selectedDate);
    };
  }

  function redirectToNewDate(selectedDate, viewMode){
    fullDatepicker = true;
    if (viewMode === 'days') {
      window.location = rewriteUrlWithSelectedDate(window.location.pathname, selectedDate);
    };
  }

  return {
    redirectToNewMonth: redirectToNewMonth,
    redirectToNewDate: redirectToNewDate
  };
}());

/* Apply viewmodel
================*/
$(function () {
  $('#datepickerMonth').datepicker()
    .on('changeDate', function(ev){
      mwd.viewModels.datepicker.redirectToNewMonth(ev.date, ev.viewMode);
  });

  $('#datepicker').datepicker()
    .on('changeDate', function(ev){
      mwd.viewModels.datepicker.redirectToNewDate(ev.date, ev.viewMode);
  });
});