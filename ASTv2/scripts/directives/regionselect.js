'use strict';

astApp.directive('regionselect', ['$log', function($log) {
    return {
        restrict: 'E',
        templateUrl: 'templates/directives/regionselect.html',
        link: function(scope, elem, attr) {
            var self = scope;
            self.simulateQuery = false;
            self.noCache = false;
            // list of `region` value/display objects
            self.regions = loadAllRegions();
            self.regionSearch = regionSearch;
            self.selectedRegionChange = selectedRegionChange;
            self.searchRegionChange = searchRegionChange;



            function regionSearch(query) {
                var results = query ? self.regions.filter(createRegionFilterFor(query)) : self.regions,
                    deferred;
                //if (self.simulateQuery) {
                //    deferred = $q.defer();
                //    $timeout(function () { deferred.resolve(results); }, Math.random() * 1000, false);
                //    return deferred.promise;
                //} else {
                //    return results;
                //}
                return results;
            }
            function searchRegionChange(text) {
                $log.info('Region Text changed to ' + text);
            }
            function selectedRegionChange(item) {
                $log.info('Region Item changed to ' + JSON.stringify(item));
            }
            /**
             * Build `regions` list of key/value pairs
             */
            function loadAllRegions() {
                var allRegions = 'ACAC Member, AFCAC Member, LACAC, European Civil Aviation Commission';
                return allRegions.split(/, +/g).map(function (region) {
                    var index = 1;
                    return {
                        value: region.toLowerCase(),
                        //value: index++,
                        display: region
                    };
                });
            }
            /**
             * Create filter function for a query string
             */
            function createRegionFilterFor(query) {
                var lowercaseQuery = angular.lowercase(query);
                return function filterFn(region) {
                    return (region.value.indexOf(lowercaseQuery) === 0);
                };
            }
        }
};
}]);