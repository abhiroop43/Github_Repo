﻿'use strict';

astApp.controller('ApplicationsController', function ($scope, $http, $timeout, $q, $log, $state) {
    $scope.$on('$viewContentLoaded', function () {
        //// initialize core components
        //Metronic.initAjax();
    });
    if ($state.params.st != undefined) {
        console.log($state.params.st);
    }
    $scope.st = $state.params.st;
    //regions//
    var self = this;
    //self.simulateQuery = false;
    //self.noCache = false;
    //// list of `region` value/display objects
    //self.regions = loadAllRegions();
    //self.regionSearch = regionSearch;
    //self.selectedRegionChange = selectedRegionChange;
    //self.searchRegionChange = searchRegionChange;

    
  
    //function regionSearch(query) {
    //    var results = query ? self.regions.filter(createRegionFilterFor(query)) : self.regions,
    //        deferred;
    //    //if (self.simulateQuery) {
    //    //    deferred = $q.defer();
    //    //    $timeout(function () { deferred.resolve(results); }, Math.random() * 1000, false);
    //    //    return deferred.promise;
    //    //} else {
    //    //    return results;
    //    //}
    //    return results;
    //}
    //function searchRegionChange(text) {
    //    $log.info('Region Text changed to ' + text);
    //}
    //function selectedRegionChange(item) {
    //    $log.info('Region Item changed to ' + JSON.stringify(item));
    //}
    ///**
    // * Build `regions` list of key/value pairs
    // */
    //function loadAllRegions() {
    //    var allRegions = 'ACAC Member, AFCAC Member, LACAC, European Civil Aviation Commission';
    //    return allRegions.split(/, +/g).map(function (region) {
    //        var index = 1;
    //        return {
    //            value: region.toLowerCase(),
    //            //value: index++,
    //            display: region
    //        };
    //    });
    //}
    ///**
    // * Create filter function for a query string
    // */
    //function createRegionFilterFor(query) {
    //    var lowercaseQuery = angular.lowercase(query);
    //    return function filterFn(region) {
    //        return (region.value.indexOf(lowercaseQuery) === 0);
    //    };
    //}

    //Application status//
    self.queryStatusSearch = queryStatusSearch;
    self.statuses = loadStatuses();
    self.selectedStatuses = [];
    self.requireMatch = true;
    self.transformChip = transformChip;

    /**
     * Return the proper object when the append is called.
     */
    function transformChip(chip) {
        // If it is an object, it's already a known chip
        if (angular.isObject(chip)) {
            return chip;
        }
        // Otherwise, create a new one
        return { name: chip, type: 'new' }
    }
    /**
     * Search for statuses.
     */
    function queryStatusSearch(query) {
        var results = query ? self.statuses.filter(createFilterFor(query)) : [];
        return results;
    }
    /**
     * Create filter function for a query string
     */
    function createFilterFor(query) {
        var lowercaseQuery = angular.lowercase(query);
        return function filterFn(status) {
            return (status._lowername.indexOf(lowercaseQuery) === 0) ||
                (status._lowertype.indexOf(lowercaseQuery) === 0);
        };
    }
    function loadStatuses() {
        var statuses = [
          {
              'name': 'Application Submitted',
              'type': '1'
          },
          {
              'name': 'Travel Docs Submitted by Applicant',
              'type': '2'
          },
          {
              'name': 'Training Attended',
              'type': '3'
          },
          {
              'name': 'Feedback Submitted',
              'type': '4'
          },
          {
              'name': 'Rejected by Training Center',
              'type': '5'
          }
        ];
        return statuses.map(function (st) {
            st._lowername = st.name.toLowerCase();
            st._lowertype = st.type.toLowerCase();
            return st;
        });
    }


    //Courses//
    self.courses = loadAllCourses();
    self.courseSearch = courseSearch;
    self.selectedCourseChange = selectedCourseChange;
    self.searchCourseChange = searchCourseChange;

    function courseSearch(query) {
        var results = query ? self.courses.filter(createCourseFilterFor(query)) : self.courses;
        return results;
    }
    function searchCourseChange(text) {
        $log.info('Region Text changed to ' + text);
    }
    function selectedCourseChange(item) {
        $log.info('Region Item changed to ' + JSON.stringify(item));
    }

    function loadAllCourses() {
        var allCourses = '2010 - course1, 2011 - course2, 2012 - course3, 2014 - course4';
        return allCourses.split(/, +/g).map(function (courses) {
            var index = 1;
            return {
                value: courses.toLowerCase(),
                //value: index++,
                display: courses
            };
        });
    }

    function createCourseFilterFor(query) {
        var lowercaseQuery = angular.lowercase(query);
        return function filterFn(courseCategories) {
            return (courseCategories.value.indexOf(lowercaseQuery) === 0);
        };
    }

});