define(['knockout', 'helper', 'postbox'], function (ko, fn, postbox) {
    "use strict";

    return function () {
        this.TileData = ko.observable();

        // Behaviours
        this.goToDetail = function (tile) {
            postbox.publish('selectedList', fn.cleanup(tile.title));
        };

        // Bootstrap
        this.TileData = app.tilesData.tiles.tile;
        // Client-side routes
    };
});