'use strict';

var astApp = angular.module('astApp', ["ui.router",
    "ui.bootstrap",
    "oc.lazyLoad",
    "ngSanitize",
    "ngResource",
    "ngRoute",
"ngMaterial"]);

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
astApp.controller('HeaderController', ['$scope', function ($scope) {
    $scope.$on('$includeContentLoaded', function () {
        Layout.initHeader(); // init header
    });

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
astApp.controller('PageHeadController', ['$scope', function ($scope) {
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
astApp.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', function ($stateProvider, $urlRouterProvider, $locationProvider) {
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
        ;

    
}]);
//end setup routing//



/* Init global settings and run the app */
astApp.run(["$rootScope", "settings", "$state", function ($rootScope, settings, $state) {
    $rootScope.$state = $state; // state to be accessed from view
}]);