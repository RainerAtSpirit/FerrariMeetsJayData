define (['knockout', 'helper'], function ( ko, fn ) {
    "use strict";

    return function () {
        // ko observables
        var userId = ko.observable ().subscribeTo ('userId'),
            selectedList = ko.observable ().subscribeTo ('selectedList'),
            TileData = ko.observableArray ([]),
        // functions
            goToDetail;

        // end of var declaration

        goToDetail = function ( tile, event ) {
            if ( userId () !== 'anonymous' ) {

                selectedList (fn.cleanup (tile.title));
                location.hash = '/view/' + selectedList ();
            }
            else {
                alert (' Make sure to log on.');
            }
        };

        // Bootstrap
        TileData (app.tilesData.tiles.tile);


        // Return public methods
        return{
            userId : userId,
            TileData : TileData,
            goToDetail : goToDetail
        };
    };
});