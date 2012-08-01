/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:35
 */
define(['jquery', 'knockout', 'LogonVM', 'TileVM', 'ListingVM', 'postbox', 'path', 'jaydata',
    'JayData1.1.1/jaydataproviders/oDataProvider.min', 'appData', 'kocBH' ],
    function ($, ko, LogonVM, TileVM, ListingVM, postbox) {
        "use strict";

        var init = function () {

            // Exposing ko as global
            window.ko = window.ko || ko;
            var $tileContainer = $('#tileVM');

            // Configuring JayData to use current site's Odata service
            app.context = new app.MetroStyleDataContext({ name : 'oData', oDataServiceHost : '../_vti_bin/listdata.svc' });

            // binding ko to the appropriate container
            ko.applyBindings(new TileVM(), document.getElementById('tileVM'));
            ko.applyBindings(new LogonVM(), document.getElementById('logonVM'));
            ko.applyBindings(new ListingVM(), document.getElementById('listingVM'));

            // Client-side routes. Path exposed as global via shim configuration
            function toggleTiles() {
                var isVisible = $tileContainer.css('display') === 'block';
                isVisible ? $tileContainer.slideUp(300) : $tileContainer.slideDown(300);
            }

            Path.map("#/view/:list").to(function () {
                postbox.publish('selectedList', this.params.list);
            }).enter(toggleTiles);

            Path.map("(#)").to(function () {
                postbox.publish('selectedList', '');
            }).enter(toggleTiles);

            Path.listen();
        };

        return {
            init : init
        }

    });
