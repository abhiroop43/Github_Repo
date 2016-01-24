'use strict';

astApp.directive('coursecategory', ['$log', function($log) {
    return {
        restrict: 'E',
        templateUrl: 'templates/directives/coursecategory.html',
        link: function(scope, element, attr) {
            var self = scope;
            self.courseCategories = loadAllCourseCategories();
            self.courseCategorySearch = courseCategorySearch;
            self.selectedCourseCategoryChange = selectedCourseCategoryChange;
            self.searchCourseCategoryChange = searchCourseCategoryChange;
            self.noCache = false;
            function courseCategorySearch(query) {
                var results = query ? self.courseCategories.filter(createCourseCategoryFilterFor(query)) : self.courseCategories;
                return results;
            }
            function searchCourseCategoryChange(text) {
                $log.info('Course category Text changed to ' + text);
            }
            function selectedCourseCategoryChange(item) {
                $log.info('Course category Item changed to ' + JSON.stringify(item));
            }
            /**
             * Build `regions` list of key/value pairs
             */
            function loadAllCourseCategories() {
                var allCourseCategories = 'test1, test2, test3, test4';
                return allCourseCategories.split(/, +/g).map(function (courseCategories) {
                    var index = 1;
                    return {
                        value: courseCategories.toLowerCase(),
                        //value: index++,
                        display: courseCategories
                    };
                });
            }
            
            function createCourseCategoryFilterFor(query) {
                var lowercaseQuery = angular.lowercase(query);
                return function filterFn(courseCategories) {
                    return (courseCategories.value.indexOf(lowercaseQuery) === 0);
                };
            }
        }
    };
}]);