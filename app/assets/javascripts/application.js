requirejs.config({
  "baseUrl" : "assets/javascripts",
  "paths" : {
    "knockout": "vendor/assets/javascripts/knockout-2.3.0.js"
  },
  "shim" : {
    "knockout": {
      deps: ["jQuery"],
      exports: "knockout"
    }
  }
});

define(['jquery', 'knockout'], function($, ko, require) {
	//TODO: Configure and call dependencies
  $(function() {
    console.log(ko);
  });
});