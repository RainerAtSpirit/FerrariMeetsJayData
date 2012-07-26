/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:02
 */

requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl : 'libs',
    paths : {
        jquery : [
            '//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min',
            'jquery.min'],
        knockout : [
            '//ajax.aspnetcdn.com/ajax/knockout/knockout-2.1.0',
            'knockout-2.1.0'],
        sammy : 'sammy-0.7.1.min',
        prettyDate : 'jquery.prettyDate',
        metrojs : 'MetroJs',
        jaydata : 'JayData1.1.1/jaydata',
        jd2ko : 'JayData1.1.1/JayDataModules/knockout',
        postbox : 'knockout-postbox.min',
        // app related files are stored separately from libs
        app : '../js/app/app',
        appData : '../js/app/metroDemo',
        helper : '../js/app/helper'
    },
    shim : {
        'prettyDate' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.prettyDate'
        },
        'sammy' : {
            deps : ['jquery'],
            exports : 'jQuery.sammmy'
        },
        'metrojs' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.metrojs'
        },
        'appdata' : {
            deps : ['jaydata'],
            exports : 'app.context'
        },
        'jd2ko' : {
            deps : ['jaydata']
        },
        'appData' : {
            deps : ['jaydata']
        },
        'postbox' : {
            deps : ['knockout']
        }
    }
});

require(['jquery', 'app', 'prettyDate', 'metrojs' ], function ($) {

    //Things that happen on dom ready
    $(function () {
        var doBind = (typeof (window.bindAppBarKeyboard) == "undefined" || window.bindAppBarKeyboard);

        // apply regular slide universally unless .exclude class is applied
        // NOTE: The default options for each liveTile are being pulled from the 'data-' attributes
        $(".live-tile, .flip-list").not(".exclude").liveTile();

        // showing UTC date as prettyDate
        $('span.prettyDate').prettyDate({ isUTC : true });

    });
});