define(['knockout', 'postbox'], function (ko, postbox) {
    "use strict";

    return function () {
        var selectedList, allItems, take, takeValues, include, orderByDescending, handleAfterRender, showTable, map, mapName, mapURL, mapFallback,
            chooseMap;

        selectedList = ko.observable('No list selected').syncWith('selectedList');
        allItems = ko.observableArray([]);

        // Setting up defaults for listing requests

        take = ko.observable(10);
        takeValues = ko.observableArray([10, 20, 50]);

        include = 'CreatedBy';
        orderByDescending = 'Modified';

        handleAfterRender = function (elements, data) {
            $(elements).find('.prettyDate').prettyDate({ isUTC : true });
        };

        showTable = ko.computed(function(){
            return selectedList() !== 'No list selected';
        });

        // Todo: DRY
        map = function (item) {
            return {
                Id : item.Id,
                Title : item.Title,
                Modified: item.Modified,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        mapName = function (item) {
            return {
                Id : item.Id,
                Title : item.Name,
                Modified: item.Modified,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        mapURL = function (item) {
            return {
                Id : item.Id,
                Title : item.URL,
                Modified: item.Modified,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        mapFallback = function (item) {
            return {
                Id : item.Id,
                Title : item.ContentType,
                Modified: item.Modified,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        chooseMap = function (list) {
            if (app.context[list].elementType.memberDefinitions.getMember('Title')) {
                return map;
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('Name')) {
                return mapName;
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('URL')) {
                return mapURL;
            }
            else {
                return mapFallback;
            }
        };

        postbox.subscribe("selectedList", function (newValue) {
            if (newValue !== '') {
                app.context[newValue]
                    .orderByDescending(function(newValue){ return newValue.Modified; })
                    //.orderByDescending("'" + newValue + ".Modified'")
                    .include(include)
                    .map(chooseMap(newValue))
                    .take(take())
                    .toArray(allItems);
            }
        });

        // Return public methods
        return {
            selectedList : selectedList,
            take: take,
            takeValues: takeValues,
            allItems : allItems,
            handleAfterRender : handleAfterRender,
            showTable: showTable
        }
    };

});