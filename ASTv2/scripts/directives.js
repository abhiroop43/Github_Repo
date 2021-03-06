﻿'use strict';

/***
GLobal Directives
***/

// Route State Load Spinner(used on page or content load)
astApp.directive('ngSpinnerBar', [
    '$rootScope',
    function($rootScope) {
        return {
            link: function(scope, element, attrs) {
                // by defult hide the spinner bar
                element.addClass('hide'); // hide spinner bar by default
                //console.log($rootScope.state);
                // display the spinner bar whenever the route changes(the content part started loading)
                $rootScope.$on('$stateChangeStart', function () {
                    $('body').addClass('page-on-load');// add page loading indicator
                    element.removeClass('hide'); // show spinner bar
                    //Layout.closeMainMenu();
                });

                // hide the spinner bar on rounte change success(after the content loaded)
                $rootScope.$on('$stateChangeSuccess', function() {
                    element.addClass('hide'); // hide spinner bar
                    $('body').removeClass('page-on-load'); // remove page loading indicator
                    //Layout.setMainMenuActiveLink('match'); // activate selected link in the sidebar menu

                    // auto scroll to page top
                    //setTimeout(function() {
                    //    Metronic.scrollTop(); // scroll to the top on content load
                    //}, $rootScope.settings.layout.pageAutoScrollOnLoad);
                });

                // handle errors
                $rootScope.$on('$stateNotFound', function() {
                    element.addClass('hide'); // hide spinner bar
                });

                // handle errors
                $rootScope.$on('$stateChangeError', function (event, toState, toParams, fromState, fromParams, error) {
                    console.log(event);
                    console.log(toState);
                    console.log(toParams);
                    console.log(fromState);
                    console.log(fromParams);
                    console.log(error);
                    element.addClass('hide'); // hide spinner bar
                });
            }
        };
    }
]);

// Handle global LINK click
astApp.directive('a',
    function () {
        return {
            restrict: 'E',
            link: function (scope, elem, attrs) {
                if (attrs.ngClick || attrs.href === '' || attrs.href === '#') {
                    elem.on('click', function (e) {
                        e.preventDefault(); // prevent link click for above criteria
                    });
                }
            }
        };
    });

// Handle Dropdown Hover Plugin Integration
astApp.directive('dropdownMenuHover', function () {
    return {
        link: function (scope, elem) {
            elem.dropdownHover();
        }
    };
});