﻿'use strict';

//global variables//
var astApp = angular.module('astApp', ["ui.router",
    "ui.bootstrap",
    "oc.lazyLoad",
    "ngSanitize",
    "ngResource",
    "ngRoute",
"ngMaterial", "restangular"]);

var BASEURI = "http://192.168.7.186:85/api";

/* Configure ocLazyLoader(refer: https://github.com/ocombe/ocLazyLoad) */
astApp.config(['$ocLazyLoadProvider', function ($ocLazyLoadProvider) {
    $ocLazyLoadProvider.config({
        cssFilesInsertBefore: 'ng_load_plugins_before' // load the above css files before a LINK element with this ID. Dynamic CSS files must be loaded between core and theme css files
    });
}]);

/* Setup global settings */
astApp.factory('settings', ['$rootScope', function ($rootScope) {
    // supported languages
    var settings = {
        layout: {
            pageAutoScrollOnLoad: 1000 // auto scroll to top on page load
        },
        layoutImgPath: Metronic.getAssetsPath() + 'admin/layout/img/',
        layoutCssPath: Metronic.getAssetsPath() + 'admin/layout/css/'
    };

    $rootScope.settings = settings;

    return settings;
}]);


astApp.controller('AppController', ['$scope', '$rootScope', function ($scope, $rootScope) {
    $scope.$on('$viewContentLoaded', function () {
        Metronic.initComponents(); // init core components
    });
}]);

/* Setup Layout Part - Header */
astApp.controller('HeaderController', ['$scope', '$window', 'authentication', function ($scope, $window, authentication) {
    $scope.$on('$includeContentLoaded', function () {
        Layout.initHeader(); // init header
        $scope.loggedInUser = JSON.parse($window.localStorage["user"]);;
    });


    //if ($window.localStorage["user"] == undefined) {
    //    authentication.login().then(function(data) {
    //        //$rootScope.currentUser = data;
    //        $window.localStorage["user"] = JSON.stringify(data);
    //        $scope.loggedInUser = JSON.parse($window.localStorage["user"]);;
    //        //console.log(data);
    //    });
    //}

    //$scope.getQS = function (st) {
    //    console.log('inside QS');
    //    //$location.path('/application-list').search('st', value);
    //    //$routeParams = { "st": st };
    //}


    //console.log($stateParams.st);
    //$scope.$route = $route;
    //$scope.$location = $location;
    //$scope.$routeParams = $routeParams;
    //console.log($location.path());
    //console.log($routeParams);
    //console.log($route.current.params);


}]);

/* Setup Layout Part - Sidebar */
astApp.controller('PageHeadController', ['$scope', '$window', function ($scope, $window) {
    $scope.$on('$includeContentLoaded', function () {
        Demo.init(); // init theme panel
    });
}]);

/* Setup Layout Part - Footer */
astApp.controller('FooterController', ['$scope', function ($scope) {
    $scope.$on('$includeContentLoaded', function () {
        Layout.initFooter(); // init footer
    });
}]);

//setup routing//
astApp.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 'RestangularProvider', function ($stateProvider, $urlRouterProvider, $locationProvider, RestangularProvider) {

    RestangularProvider.setBaseUrl(BASEURI);
    RestangularProvider.setDefaultHeaders({
        'Content-Type': 'application/json'
        //'X-Requested-With': 'XMLHttpRequest'
        //'Access-Control-Allow-Origin': 'http://192.168.7.186:84'
    });
    RestangularProvider.setDefaultHttpFields({
        'withCredentials': true
    });
    RestangularProvider.setRestangularFields({
        id: '_id.$oid'
    });

    RestangularProvider.setRequestInterceptor(function (elem, operation, what) {

        if (operation === 'put') {
            elem._id = undefined;
            return elem;
        }
        return elem;
    });

    // Redirect any unmatched url
    $urlRouterProvider.otherwise("/application-list");
    $locationProvider.html5Mode(true);

    $stateProvider
       .state('application-list', {
           url: "/application-list",
           templateUrl: "templates/application-list.html",
           data: { pageTitle: 'Applications', pageSubTitle: 'View List of Applications' },
           controller: "ApplicationsController",
           controllerAs: "ctrl",
           resolve: {
               deps: [
                   '$ocLazyLoad', function ($ocLazyLoad) {
                       return $ocLazyLoad.load({
                           name: 'astApp',
                           insertBefore: '#ng_load_plugins_before', // load the above css files before '#ng_load_plugins_before'
                           files: [
                               'scripts/controllers/ApplicationsController.js'
                           ]
                       });
                   }
               ]
           }
       })
    .state('application-list.st', {
        url: "?st",
        templateUrl: 'templates/application-list.html',
        data: { pageTitle: 'Applications', pageSubTitle: 'View List of Applications' },
        controller: "ApplicationsController",
        controllerAs: "ctrl",
        resolve: {
            deps: [
                '$ocLazyLoad', function ($ocLazyLoad) {
                    return $ocLazyLoad.load({
                        name: 'astApp',
                        insertBefore: '#ng_load_plugins_before', // load before '#ng_load_plugins_before'
                        files: [
                            'scripts/controllers/ApplicationsController.js'
                        ]
                    });
                }
            ]
        }
    })
    .state('courses-list', {
        url: "/courses-list",
        templateUrl: "templates/courses-list.html",
        data: { pageTitle: 'Courses', pageSubTitle: 'View List of Courses' },
        controller: "CoursesController",
        controllerAs: "coursesCtrl",
        resolve: {
            deps: [
                '$ocLazyLoad', function ($ocLazyLoad) {
                    return $ocLazyLoad.load({
                        name: 'astApp',
                        insertBefore: '#ng_load_plugins_before',
                        files: [
                            'scripts/controllers/CoursesController.js'
                        ]
                    });
                }
            ]
        }
    })
    .state('regions', {
        url: "/regions",
        templateUrl: "templates/regions.html",
        data: { pageTitle: 'Regions', pageSubTitle: 'View List of Regions' },
        controller: "RegionsController",
        controllerAs: "regionsCtrl",
        resolve: {
            deps: [
                    '$ocLazyLoad', function ($ocLazyLoad) {
                        return $ocLazyLoad.load({
                            name: 'astApp',
                            insertBefore: '#ng_load_plugins_before',
                            files: [
                                'scripts/controllers/RegionsController.js'
                            ]
                        });
                    }
            ]
        }
    })
    ;



}]);
//end setup routing//



/* Init global settings and run the app */
astApp.run(["$rootScope", "settings", "$state", "$window", "authentication", function ($rootScope, settings, $state, $window, authentication) {

    $rootScope.$state = $state; // state to be accessed from view
    if ($window.localStorage["user"] == undefined) {
        authentication.login().then(function(data) {
            $rootScope.currentUser = data;
            $window.localStorage["user"] = JSON.stringify(data);
            if (data.UserRoleID != 6) {
                $window.location.href = "http://www.google.com/";
            }
            //console.log(data);
        });
    } else {
        var user = JSON.parse($window.localStorage["user"]);
        if (user.UserRoleID != 6) {
            $window.location.href = "http://www.google.com/";
        }
    }
    
}]);