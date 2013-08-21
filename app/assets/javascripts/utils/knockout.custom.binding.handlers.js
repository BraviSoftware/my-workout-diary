// ########################
// # Custom Bind Handlers #
// ########################


(function () {
    // Tooltip JS
    //-------------------------
    ko.bindingHandlers.tooltip = {
        init: function (elemenet, valueAccessor) {
            setTimeout(function(){
                $(elemenet).tooltip({container: 'body'}); 
            }, 250);
        }
    };
})();