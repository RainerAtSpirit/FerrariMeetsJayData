define(['knockout'], function (ko) {
    "use strict";

    return function () {
        var userId, loginURL;

        userId = ko.observable(app.configMap.userId).publishOn('userId');

        // Behaviours

        loginURL = ko.computed(function () {
            return '../_layouts/Authenticate.aspx?Source=' + encodeURIComponent(location.pathname) + location.hash;
        });


        // Return public methods
        return {
            userId : userId,
            loginURL : loginURL
        }
    }
});