define(['knockout'], function (ko) {
    "use strict";

    return function () {
        this.userId = ko.observable();
        this.userId = app.configMap.userId;


        this.showLogon = ko.computed(function () {
            return this.userId === 'anonymous';
        }, this);

        this.loginURL = ko.computed(function () {
            return '../_layouts/Authenticate.aspx?Source=' + encodeURIComponent(location.pathname)
        }, this);
    }
});