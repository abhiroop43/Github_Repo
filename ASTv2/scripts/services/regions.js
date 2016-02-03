'use strict';

astApp.factory('Regions', ['$log', 'Restangular', function ($log, Restangular) {
    //var regions;
    function getAllRegions() {
        //Restangular.one("regions").get().then(function (rgns) {
        //    //$log.log(rgns);
        //    regions = rgns;
        //});
        //regions = Restangular.one("regions").get();
        //$log.log(regions);
        //return regions;
    }

    //getAllRegions();
    //return {
    //    getAllRegions: getAllRegions
    //}

    return Restangular.service('regions');
}]);