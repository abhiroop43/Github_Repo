'use strict';

astApp.factory("authentication", ["$http", "$q", "$window", "Restangular", authentication]);

function authentication($http, $q, $window, Restangular) {

    var user;

    function login() {

        // check if the user already exists for this session
        if (user) {
            return $q.when(user); // resolve with given value, necessary because calling function expects a promise.
            //return user;
        }

        //var url = BASEURI + 'users/current/';
        //return $http.get(url).then(function (result) {
        //    var res = result.data;

        //    user = {
        //        id: result.UserRoleTaggingID,
        //        displayName: result.Name
        //    };

        //    addUserToStorage();

        //    console.log("user created.");
        //    return $q.when(user);
        //});

        var currentUser = Restangular.one("users/current");
        //currentUser.get(function (result) {
        //    user = {
        //        id: result.UserRoleTaggingID,
        //        displayName: result.Name
        //    };

        //    addUserToStorage();

        //    console.log("user created.");
        //    return $q.when(user);;
        //});
        return currentUser.get();
    }

    function addUserToStorage() {
        $window.sessionStorage["user"] = JSON.stringify(user);
    }

    function getUser() {
        return user;
    }

    function init() {
        if ($window.sessionStorage["user"]) {
            user = JSON.parse($window.sessionStorage["user"]);
        }
    }

    init();

    return {
        user: user,
        init: init,
        addUserToStorage: addUserToStorage,
        login: login,
        getUser: getUser
    };
};