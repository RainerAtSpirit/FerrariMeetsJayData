define(['knockout', 'helper'], function (ko, fn) {
    "use strict";

    return function () {
        var userId, selectedList, TileData, goToDetail;

        userId = ko.observable().subscribeTo('userId');
        selectedList = ko.observable().subscribeTo('selectedList');

        TileData = ko.observableArray([]);

        // Behaviours
        goToDetail = function (tile, event) {
            if (userId() !== 'anonymous') {

                selectedList(fn.cleanup(tile.title));
                location.hash = '/view/' + selectedList();
                //$(event.currentTarget).parent('div').slideUp('fast');
            }
            else {
                alert(' Make sure to log on.');
            }
        };

        // Bootstrap
        TileData(app.tilesData.tiles.tile);


        // Return public methods
        return{
            userId : userId,
            TileData : TileData,
            goToDetail : goToDetail
        };
    };
});