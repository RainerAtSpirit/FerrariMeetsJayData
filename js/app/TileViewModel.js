define(['knockout', 'helper', 'postbox'], function (ko, fn, postbox) {
    "use strict";

    return function () {
        var userId, TileData, goToDetail;

        userId = ko.observable().subscribeTo('userId');

        TileData = ko.observableArray([]);

        // Behaviours
        goToDetail = function (tile) {
            if ( userId() !== 'anonymous'){
                postbox.publish('selectedList', fn.cleanup(tile.title));
            }
            else {
                alert(' Make sure to log on.');
            }
        };

        // Bootstrap
        TileData(app.tilesData.tiles.tile);


        // Return public methods
        return{
            userId: userId,
            TileData : TileData,
            goToDetail : goToDetail
        };
    };
});