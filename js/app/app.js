/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['knockout', 'helper', 'postbox', 'underscore', 'jaydata', 'appData', 'jd2ko'], function (ko, fn, postbox, _) {

    var app = window.app || {},
        TileViewModel, LogonViewModel, ListingModel, init;



    app.context = new app.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });


    TileViewModel = function () {
        // Data
        var self = this;
        self.TileData = ko.observable();

        // Behaviours
        self.goToDetail = function (tile) {
            postbox.publish('selectedList', fn.cleanup(tile.title));
        };

        // Bootstrap
        self.TileData = app.tilesData.tiles.tile;
        // Client-side routes
    };

     LogonViewModel = function () {
        var self = this;
        self.userId = ko.observable();
        self.userId = app.configMap.userId;


        self.showLogon = ko.computed(function () {
            return self.userId === 'anonymous';
        }, self);

        self.loginURL = ko.computed(function () {
            return '../_layouts/Authenticate.aspx?Source=' + encodeURIComponent(location.pathname)
        }, self);

    };

    ListingModel = function () {
        var self = this;
        self.selectedList = ko.observable('').syncWith('selectedList');

        self.allItems = ko.observableArray([]);

        // Setting up defaults for listing requests
        self.take = 50;
        self.include = 'CreatedBy';

        // Todo: DRY
        self.map = function (item) {
            return {
                Id : item.Id,
                Title : item.Title,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        self.mapName = function (item) {
            return {
                Id : item.Id,
                Title : item.Name,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        self.mapURL = function (item) {
            return {
                Id : item.Id,
                Title : item.URL,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        self.mapFallback = function (item) {
            return {
                Id : item.Id,
                Title : item.ContentType,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        chooseMap = function(list) {
           if ( app.context[list].elementType.memberDefinitions.getMember('Title') ){
               return self.map;
           }
           else if  ( app.context[list].elementType.memberDefinitions.getMember('Name') ){
               return self.mapName;
           }
           else if ( app.context[list].elementType.memberDefinitions.getMember('URL') ){
               return self.mapURL;
           }
           else {
               return self.Fallback;
           }
       };

        postbox.subscribe("selectedList", function (newValue) {
            // Check if current list has a Title field defined


            if (newValue !== '') {
                app.context[newValue]
                    .include(self.include)
                    .map(chooseMap(newValue))
                    .take(self.take)
                    .toArray(self.allItems);
            }
        }, self);

    };

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

        ko.applyBindings(new TileViewModel(), document.getElementById('metroTiles'));
        ko.applyBindings(new LogonViewModel(), document.getElementById('loginHelper'));
        ko.applyBindings(new ListingModel(), document.getElementById('listingView'));
    };


    return {
        init: init
    }

});
