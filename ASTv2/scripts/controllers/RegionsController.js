'use strict';

astApp.controller('RegionsController', function ($scope, $log, Regions) {
    $scope.$on('$viewContentLoaded', function () {
        //// initialize core components
        //Metronic.initAjax();
    });
    var reg = this;
    reg.allRegionsPromise = Regions.one().get();
    //$log.log(reg.allRegionsPromise);

    reg.allRegionsPromise.then(function (data) {
        reg.regions = data;
    });

    //reg.goToNewRegionForm = function () {
    //    $state.go("new-region");
    //};

    //reg.regions = Regions.getList().$object;
    //Regions.getAllRegions().then(function (rgns) {
    //        //$log.log(rgns);
    //        reg.regions = rgns;
    //    });
    //Restangular.one("regions").get().then(function (rgns) {
    //    reg.regions = rgns;
    //    console.log(rgns);
    //});


    //var currentUser = Restangular.one("users/current");
    //currentUser.get().then(function (usr) {
    //    $scope.regions = usr;
    //    console.log(usr);
    // });

    //$http({
    //    method: 'GET',
    //    withCredentials: true,
    //    url: 'http://192.168.7.186:85/api/users/current/'
    //}).then(function successCallback(response) {
    //    console.log(response.data);
    //}, function errorCallback(response) {
    //    console.log('Error', response);
    //});

    //console.log($scope.projects);
});