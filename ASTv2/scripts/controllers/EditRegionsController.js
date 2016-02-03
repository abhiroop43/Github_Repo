'use strict';

astApp.controller('EditRegionsController', function ($scope, $log, $state, $window, Regions, FileUpload, SweetAlert, FileUploader) {
    $scope.$on('$viewContentLoaded', function () {
        //// initialize core components
        //Metronic.initAjax();
    });
    //$log.log($state.params.id);
    var rgn = this;
    rgn.modelData = {};
    rgn.regionFiles = [];
    rgn.regionId = $state.params.id;
    rgn.regionPromise = Regions.one("/" + rgn.regionId).get();
    rgn.regionPromise.then(function (data) {
        //$log.log(data);
        //$log.log(rgn.regionPromise);
        rgn.modelData = data;

        FileUpload.getFiles.one("/" + rgn.modelData.RegionId).get().then(function(files) {
            rgn.regionFiles = files;
            $log.log("File data fetched",files);
        });
    });
    //$log.log(rgn.regionPromise);
    rgn.loggedInUser = JSON.parse($window.localStorage["user"]);

    

    

    rgn.uploader = new FileUploader();
    //rgn.uploader.url = "";


    //submit//
    rgn.EditRegion = function (modelData) {

        //alert("Success");
        SweetAlert.swal({
            title: "Are you sure?",
            text: "Please confirm update of region",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, update region",
            cancelButtonText: "No",
            closeOnConfirm: false,
            closeOnCancel: false
        },
function (isConfirm) {
    if (isConfirm) {
        Regions.getList().then(function (regions) {
            var currRegion = _.find(regions, function (obj) { return obj.RegionId === modelData.RegionId });
            //$log.log("Current Region", currRegion);
            currRegion.Abrv = modelData.Abrv;
            currRegion.Name = modelData.Name;
            currRegion.NameAr = modelData.NameAr;
            currRegion.Description = modelData.Description;
            currRegion.DescriptionAr = modelData.DescriptionAr;
            currRegion.IsEnabled = modelData.IsEnabled;
            currRegion.UpdateUserID = rgn.loggedInUser.UserID;
            currRegion.put().then(function (msg) {
                //$log.log('Submit success', modelData);
                SweetAlert.swal({
                    title: msg,
                    text: "Redirecting you back to the Regions List",
                    type: "success"
                },
                    function () {
                        $state.go("regions");
                    });
            }, function (err) {
                $log.log("Update Region error", err);
                SweetAlert.swal("Update failed", "Please contact the administrator", "error");
            });    //put operation ends//
            currRegion.put();
            //currRegion.save();

            //SweetAlert.swal({
            //    title: "Region Updated",
            //    text: "Redirecting you back to the Regions List",
            //    type: "success"
            //},
            //        function () {
            //            $state.go("regions");
            //        });

        },
        function (err) {
            $log.log("Update operation getlist error", err);
            SweetAlert.swal("Update failed", "Please contact the administrator", "error");
        });

    } else {
        SweetAlert.swal("Update Cancelled", "You cancelled the update operation", "error");
    }
});
    }
});