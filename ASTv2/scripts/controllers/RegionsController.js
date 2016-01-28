'use strict';

astApp.controller('RegionsController', function ($scope, $http, Restangular, authentication) {
    $scope.$on('$viewContentLoaded', function () {
        //// initialize core components
        //Metronic.initAjax();
    });
    var reg = this;
    reg.regions = [];
    Restangular.one("regions").get().then(function (rgns) {
        reg.regions = rgns;
        console.log(rgns);
    });


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