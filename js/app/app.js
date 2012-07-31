/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['jquery', 'knockout', 'LogonVM', 'TileVM', 'ListingVM', 'postbox', 'path', 'appData', 'jaydata',
    'JayData1.1.1/jaydataproviders/oDataProvider', 'jd2ko', 'kocBH' ],
    function ($, ko, LogonVM, TileVM, ListingVM, postbox) {
        "use strict";
        var $tileContainer = $('#tileVM');

        var init = function () {

            // Configuring JayData to use current site Odata service
            app.context = new app.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });


            ko.applyBindings(new TileVM(), document.getElementById('tileVM'));
            ko.applyBindings(new LogonVM(), document.getElementById('logonVM'));
            ko.applyBindings(new ListingVM(), document.getElementById('listingVM'));

            // Client-side routes. Path exposed as global via shim configuration
            function toggleTiles(){
                var isVisible = $tileContainer.css('display') === 'block';
                isVisible ? $tileContainer.slideUp(300) : $tileContainer.slideDown(300);
            }

            Path.map("#/view/:list").to(function(){
                postbox.publish('selectedList', this.params.list);
            }).enter(toggleTiles);

            Path.map("").to(function(){
                postbox.publish('selectedList', '');
            }).enter(toggleTiles);


            Path.listen();

        };

        return {
            init : init
        }

    });
