/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['knockout', 'helper'], function (ko, fn) {

    function TileViewModel() {
        // Data
        var self = this;
        self.TileData = ko.observable();
        // Behaviours

        self.goToDetail = function (tile) {
            alert(fn.cleanup(tile.title));
        };
        // Bootstrap
        self.TileData = app.tilesData.tiles.tile;
        // Client-side routes
    }

    function LogonViewModel(){
        var self = this;
        self.userId = ko.observable();
        self.userId = app.configMap.userId;

        self.showLogon = function ( user ){
           return user.userId === 'anonymous' ;
        }

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

});
