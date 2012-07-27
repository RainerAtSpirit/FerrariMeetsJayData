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
});