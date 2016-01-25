'use strict';

astApp.controller('CoursesController', function ($scope) {
    $scope.$on('$viewContentLoaded', function () {
    });
    

    var self = this;
    self.states = loadAll();
    self.selectedItem = null;
    self.searchText = null;
    self.querySearch = querySearch;

    function querySearch(query) {
        var results = query ? self.states.filter(createFilterFor(query)) : [];
        return results;
    }

    function loadAll() {
        var allStates = 'Academy Technical Training, Etihad Training, Gulf Aviation Academy, Qatar Aviation College';
        return allStates.split(/, +/g).map(function (state) {
            return {
                value: state.toLowerCase(),
                display: state
            };
        });
    }
    /**
     * Create filter function for a query string
     */
    function createFilterFor(query) {
        var lowercaseQuery = angular.lowercase(query);
        return function filterFn(state) {
            return (state.value.indexOf(lowercaseQuery) === 0);
        };
    }
});