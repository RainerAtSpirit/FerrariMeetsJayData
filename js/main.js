/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:02
 */

requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl : 'libs',
    paths : {
       // Try loading from CDN first
       jquery : [
            '//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min',
            'jquery.min'],
        knockout : [
            '//ajax.aspnetcdn.com/ajax/knockout/knockout-2.1.0',
            'knockout-2.1.0'],
        underscore : [
            '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min',
            'underscore-min'
        ],
        /*
            jquery: 'jquery.min',
            knockout: 'knockout-2.1.0',
            underscore: 'underscore-min',
        */
        kocBH : '../js/app/CustomBindingHandler',
        prettyDate : 'jquery.prettyDate',
        metrojs : 'MetroJs',
        jaydata : 'JayData1.1.1/jaydata.min',
        jd2ko : 'JayData1.1.1/JayDataModules/knockout',
        postbox : 'knockout-postbox.min',

        // app related files are stored separately from libs

        app : '../js/app/app',
        appData : '../js/app/appdata',
        helper : '../js/app/helper',
        LogonVM : '../js/app/LogonViewModel',
        TileVM : '../js/app/TileViewModel',
        ListingVM : '../js/app/ListingViewModel'
    },
    shim : {
        'prettyDate' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.prettyDate'
        },
        'metrojs' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.metrojs'
        },
        'JayData1.1.1/jaydataproviders/oDataProvider.min' : {
            deps : ['jaydata']
        },
        'jd2ko' : {
            deps : ['jaydata', 'knockout']
        },
        'postbox' : {
            deps : ['knockout']
        }
    }
});

require(['jquery', 'app', 'prettyDate', 'metrojs'], function ($, app) {

    // we can safely kick of the app even before document.ready
    app.init();

});