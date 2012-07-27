/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['knockout', 'LogonVM', 'TileVM', 'ListingVM', 'jaydata', 'appData', 'jd2ko', 'kocBH'],
    function (ko, LogonVM, TileVM, ListingVM) {
    "use strict";

    var app = window.app || {},
         init;

    // Using JayData talking to local Odata service
    app.context = new app.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });

    init = function() {
        ko.applyBindings(new TileVM(), document.getElementById('tileVM'));
        ko.applyBindings(new LogonVM(), document.getElementById('logonVM'));
        ko.applyBindings(new ListingVM(), document.getElementById('listingVM'));
    };

    return {
        init: init
    }

});
