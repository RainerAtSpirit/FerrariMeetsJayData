define(['knockout', 'postbox'], function (ko, postbox) {
    "use strict";

    return function () {
        this.selectedList = ko.observable('').syncWith('selectedList');
        this.allItems = ko.observableArray([]);

        // Setting up defaults for listing requests
        this.take = 50;
        this.include = 'CreatedBy';

        this.handleAfterRender = function (elements, data) {
            $(elements).find('.prettyDate').prettyDate({ isUTC : true });
        };

        // Todo: DRY
        this.map = function (item) {
            return {
                Id : item.Id,
                Title : item.Title,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        this.mapName = function (item) {
            return {
                Id : item.Id,
                Title : item.Name,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        this.mapURL = function (item) {
            return {
                Id : item.Id,
                Title : item.URL,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        this.mapFallback = function (item) {
            return {
                Id : item.Id,
                Title : item.ContentType,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        this.chooseMap = function (list) {
            if (app.context[list].elementType.memberDefinitions.getMember('Title')) {
                return this.map;
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('Name')) {
                return this.mapName;
            }
            else if (app.context[list].elementType.memberDefinitions.getMember('URL')) {
                return this.mapURL;
            }
            else {
                return this.Fallback;
            }
        };

        postbox.subscribe("selectedList", function (newValue) {
            if (newValue !== '') {
                app.context[newValue]
                    .include(this.include)
                    .map(this.chooseMap(newValue))
                    .take(this.take)
                    .toArray(this.allItems);
            }
        }, this);

    };

});