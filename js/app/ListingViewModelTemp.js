define(['knockout', 'postbox', 'underscore'], function (ko, postbox) {
    "use strict";

    return function () {
        var selectedList, allItems, userId, take, takeValues, includeArray, itemTitle, orderBy, orderAsc, handleAfterRender, showTable,
            chooseMap;

        selectedList = ko.observable('').syncWith('selectedList');
        allItems = ko.observableArray([]);
        userId = ko.observable().subscribeTo('userId');
        // defaults for OData requests

        take = ko.observable(10);
        takeValues = ko.observableArray([10, 20, 50]);
        orderBy = ko.observable('Modified');
        orderAsc = ko.observable(false);
        includeArray = ko.observableArray(['CreatedBy', 'ModifiedBy']);
        itemTitle = ko.observable('Title');

        handleAfterRender = function (elements, data) {
            $(elements).find('.prettyDate').prettyDate({ isUTC : true });
        };

        showTable = ko.computed(function () {
            return selectedList() !== '';
        });



        chooseMap = function (list) {

            if (app.context[list].elementType.memberDefinitions.getMember('Title')) {
                itemTitle('Title');

                return "{ Id: it.Id, Title: it." + itemTitle() + ", Modified: it.Modified, Created: it.Created, CreatedBy : it.CreatedBy.Name }";
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('Name')) {
                itemTitle('Name');

                return "{ Id: it.Id, Title: it." + itemTitle() + ", Modified: it.Modified, Created: it.Created, CreatedBy : it.CreatedBy.Name }";
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('URL')) {
                itemTitle('URL');
                return "{ Id: it.Id, Title: it." + itemTitle() + ", Modified: it.Modified, Created: it.Created, CreatedBy : it.CreatedBy.Name }";
            }
            else {
                itemTitle('ContentType');
                return "{ Id: it.Id, Title: it." + itemTitle() + ", Modified: it.Modified, Created: it.Created, CreatedBy : it.CreatedBy.Name }";
            }
        };

        postbox.subscribe("selectedList", function (newValue) {
            if (app.configMap.userId === 'anonymous'){
                return alert ('Make sure to log on.');
            }
            if (newValue !== '') {
                var base = app.context[newValue],
                    myBase = _.extend({}, base),
                    sortExp = 'it.' + orderBy();

                if (orderAsc()) {
                    _.extend(myBase, myBase.orderBy(sortExp));
                }
                else {
                    _.extend(myBase, myBase.orderByDescending(sortExp));
                }
                _.each(includeArray(), function (inc) {
                    _.extend(myBase, myBase.include(inc));
                });
                _.extend(myBase, myBase.map(chooseMap(newValue)));
                _.extend(myBase, myBase.take(take()));

            }

            myBase.toArray(allItems);
        });

        // Return public methods
        return {
            selectedList : selectedList,
            take : take,
            takeValues : takeValues,
            allItems : allItems,
            handleAfterRender : handleAfterRender,
            showTable : showTable
        }
    };

});