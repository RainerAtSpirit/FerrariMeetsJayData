/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['knockout', 'helper', 'postbox', 'jaydata', 'appData', 'jd2ko'], function (ko, fn, postbox) {

    var app = window.app || {};

    app.context = new app.jaydata.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });


    function TileViewModel() {
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
    }

    function LogonViewModel() {
        var self = this;
        self.userId = ko.observable();
        self.userId = app.configMap.userId;


        self.showLogon = ko.computed(function () {
            return self.userId === 'anonymous';
        }, self);

        self.loginURL = ko.computed(function () {
            return '../_layouts/Authenticate.aspx?Source=' + encodeURIComponent(location.pathname)
        }, self);

    }

    function ListingModel() {
        var self = this;
        self.selectedList = ko.observable('').syncWith('selectedList');

        self.allItems = ko.observableArray([]);

        // Setting up defaults for listing requests
        self.take = 50;
        self.map = function (item) {
            return {
                Id : item.Id,
                Title : item.Title,
                Created : item.Created,
                CreatedBy : item.CreatedBy.Name
            };
        };

        postbox.subscribe("selectedList", function (newValue) {
            if (newValue !== '') {
                app.context[newValue]
                    .include('CreatedBy')
                    .map(self.map)
                    .take(self.take)
                    .toArray(self.allItems);
            }
        }, self);

    }

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

});
