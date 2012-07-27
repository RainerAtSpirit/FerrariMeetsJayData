/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['knockout', 'LogonVM', 'TileVM', 'ListingVM', 'jaydata', 'appData', 'jd2ko'],
    function (ko, LogonVM, TileVM, ListingVM) {
    "use strict";

    var app = window.app || {},
         init;

    // JayData talking to local Odata service
    app.context = new app.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });

    init = function() {
        // See https://github.com/SteveSanderson/knockout/wiki/Bindings---class
        ko.bindingHandlers['class'] = {
            'update' : function (element, valueAccessor) {
                if (element['__ko__previousClassValue__']) {
                    ko.utils.toggleDomNodeCssClass(element, element['__ko__previousClassValue__'], false);
                }
                var value = ko.utils.unwrapObservable(valueAccessor());
                ko.utils.toggleDomNodeCssClass(element, value, true);
                element['__ko__previousClassValue__'] = value;
            }
        };

        ko.applyBindings(new TileVM(), document.getElementById('tileVM'));
        ko.applyBindings(new LogonVM(), document.getElementById('logonVM'));
        ko.applyBindings(new ListingVM(), document.getElementById('listingVM'));
    };

    return {
        init: init
    }

});
