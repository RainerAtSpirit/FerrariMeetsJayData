define(['knockout'], function (ko) {
    "use strict";
    // No need to return something as we only extend the ko module

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
    // See http://stackoverflow.com/questions/10231347/knockout-afterrender-but-just-once
    ko.bindingHandlers.updateTilesOnce = {
        init : {
        },
        update : function (element, valueAccessor, allBindingsAccessor, viewModel) {
            // This will be called once when the binding is first applied to an element,
            // and again whenever the associated observable changes value.
            // Update the DOM element based on the supplied values here.

            var tileOptions = valueAccessor().liveTile || {};

            if ($(element).find('.live-tile').length > 0) {
                $(element).find('.live-tile')
                    .liveTile(tileOptions)
                    .click(function () {
                        $(this).liveTile('play');
                    })
                    .find('.prettyDate').prettyDate({ isUTC : true });
            }

        }
    };
});