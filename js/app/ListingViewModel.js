define (['knockout', 'postbox', 'underscore', 'jd2ko', 'appData'], function ( ko, postbox ) {
    "use strict";

    return function () {
        // ko observables
        var allItems = ko.observableArray ([]),
            itemDetail = ko.observableArray ([]),
            selectedList = ko.observable ('').syncWith ('selectedList'),
            userId = ko.observable ().subscribeTo ('userId'),

        // defaults for OData requests as ko observables

            includeArray = ko.observableArray (['CreatedBy', 'ModifiedBy']),
            orderAsc = ko.observable (false),
            orderBy = ko.observable ('Modified'),
            take = ko.observable (10),
            takeValues = ko.observableArray ([10, 20, 50]),

        // functions and ko.compute
            handleAfterRender,
            showTable,
            showDetails,
            chooseMap,
            getDetails;

        // end of var declaration

        handleAfterRender = function ( elements, data ) {
            // Enabling prettyDate
            $ (elements).find ('.prettyDate').prettyDate ({ isUTC : true });
            // Enabling live tiles
            var x = data;
        };

        showTable = ko.computed (function () {
            return selectedList () !== '';
        });

        showDetails = ko.computed (function () {
            return itemDetail ().length > 0;
        });

        chooseMap = function ( list ) {
            var defaultMap, convertMap;

            defaultMap = {
                Id : 'it.Id',
                Title : 'it.Title',
                Modified : 'it.Modified',
                Created : 'it.Created',
                CreatedBy : 'it.CreatedBy.Name'
            };

            convertMap = function ( map ) {
                var values = [];
                _.each (map, function ( val, key ) {
                    values.push (key + ': ' + val)
                });
                return '{' + values.join (', ') + '}'
            };

            if ( app.context[list].elementType.memberDefinitions.getMember ('Title') && app.context[list].elementType.memberDefinitions.getMember ('Name') ) {
                return convertMap (_.extend (defaultMap, {Title : 'it.Name'}));
            }
            else if ( app.context[list].elementType.memberDefinitions.getMember ('Title') ) {
                return convertMap (defaultMap);
            }
            else if ( app.context[list].elementType.memberDefinitions.getMember ('URL') ) {
                return convertMap (_.extend (defaultMap, {Title : 'it.URL'}));
            }
            else {
                return convertMap (_.extend (defaultMap, {Title : 'it.ContentType'}));
            }
        };

        postbox.subscribe ("selectedList", function ( newValue ) {
            if ( app.configMap.userId === 'anonymous' ) {
                return alert ('Make sure to log on.');
            }
            if ( newValue !== '' ) {
                // Clean out existing itemDetail
                itemDetail ([]);
                var base = app.context[newValue],
                    myBase = _.extend ({}, base),
                    sortExp = 'it.' + orderBy ();

                if ( orderAsc () ) {
                    _.extend (myBase, myBase.orderBy (sortExp));
                }
                else {
                    _.extend (myBase, myBase.orderByDescending (sortExp));
                }
                _.each (includeArray (), function ( inc ) {
                    _.extend (myBase, myBase.include (inc));
                });
                myBase.map (chooseMap (newValue))
                    .take (take ())
                    .toArray (allItems);
            }
            else {
                // Clean out existing allItems
                allItems ([]);
                // Clean out existing itemDetail
                itemDetail ([]);
            }
        });

        getDetails = function ( currItem ) {
            var currentList = selectedList ();

            app.context[currentList]
                .single (function ( item ) {
                    return item.Id == this.Id
                },
                {Id : currItem.Id},
                function ( item ) {
                    var keyValue = [];
                    _.each (item.toJSON (), function ( val, key ) {
                        keyValue.push ({"key" : key, "val" : val});
                    });
                    itemDetail ([]);
                    ko.utils.arrayPushAll (itemDetail (), keyValue);
                    itemDetail.valueHasMutated ();
                });
        };

        // Return public methods
        return {
            selectedList : selectedList,
            take : take,
            takeValues : takeValues,
            allItems : allItems,
            itemDetail : itemDetail,
            handleAfterRender : handleAfterRender,
            showTable : showTable,
            showDetails : showDetails,
            getDetails : getDetails
        }
    };

});