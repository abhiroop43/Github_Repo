'use strict';

astApp.controller('EditRegionsController', function ($scope, $log, $state, $window, Regions, FileUpload, SweetAlert, FileUploader, FileSaver, Blob) {
    $scope.$on('$viewContentLoaded', function () {
        //// initialize core components
        //Metronic.initAjax();
    });
    //$log.log($state.params.id);
    var rgn = this;
    rgn.modelData = {};
    rgn.regionFiles = [];
    rgn.data = {}; //init variable
    //rgn.fileToBeUploaded = {};
    rgn.regionId = $state.params.id;
    rgn.regionPromise = Regions.one("/" + rgn.regionId).get();
    rgn.regionPromise.then(function (data) {
        //$log.log(data);
        //$log.log(rgn.regionPromise);
        rgn.modelData = data;
        getUploadedFiles();
    });

    function getUploadedFiles() {
        FileUpload.getFiles.one("/" + rgn.modelData.RegionId).get().then(function (files) {
            rgn.regionFiles = files;
            //$log.log("File data fetched",files);
        }, function(err) {
            $log.log("Error while retrieving files", err);
            rgn.regionFiles = [];
        });
    }

    rgn.loggedInUser = JSON.parse($window.localStorage["user"]);

    function base64toBlob(base64Data, contentType) {
        contentType = contentType || '';
        var sliceSize = 1024;
        var byteCharacters = atob(base64Data);
        var bytesLength = byteCharacters.length;
        var slicesCount = Math.ceil(bytesLength / sliceSize);
        var byteArrays = new Array(slicesCount);

        for (var sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
            var begin = sliceIndex * sliceSize;
            var end = Math.min(begin + sliceSize, bytesLength);

            var bytes = new Array(end - begin);
            for (var offset = begin, i = 0 ; offset < end; ++i, ++offset) {
                bytes[i] = byteCharacters[offset].charCodeAt(0);
            }
            byteArrays[sliceIndex] = new Uint8Array(bytes);
        }
        return new Blob(byteArrays, { type: contentType });
    }


    rgn.DownloadFile = function (fileData, fileName) {
        var data = base64toBlob(fileData, 'application/octet-stream;charset=utf-16le;base64');
        FileSaver.saveAs(data, fileName);
    }


    var fileSelect = document.createElement('input'); //input it's not displayed in html, I want to trigger it form other elements
    fileSelect.type = 'file';

    if (fileSelect.disabled) { //check if browser support input type='file' and stop execution of controller
        return;
    }

    rgn.uploadSelectedFile = function () {
        fileSelect.click();
    }


    fileSelect.onchange = function () { //set callback to action after choosing file
        var f = fileSelect.files[0], r = new FileReader();
        var filename = f.name;
        r.onloadend = function (e) { //callback after files finish loading
            rgn.data.b64 = e.target.result;

            //upload to server//
            var fileHeader = rgn.data.b64.split(',')[0];
            var fileContent = rgn.data.b64.split(',')[1];
            var headerData = fileHeader.split(';')[0];
            var fileType = headerData.split(':')[1];

            var currentUser = JSON.parse($window.localStorage["user"]);

            var uploadFileJSON = {};
            uploadFileJSON.RegionID = rgn.modelData.RegionId;
            uploadFileJSON.FileName = filename;
            uploadFileJSON.FileType = fileType;
            uploadFileJSON.FileUploaded = fileContent;
            uploadFileJSON.RecUserID = currentUser.UserID;
            uploadFileJSON.IsEnabled = true;
            uploadFileJSON.IsDeleted = false;
            FileUpload.uploadFiles.post(uploadFileJSON).then(function (response) {
                $log.log("Upload Success", response);
                    getUploadedFiles();
                },
            function (err) {
                $log.log("Upload Error", err);
            });

            //$log.log(rgn.data.b64);
            //$log.log(fileType);
            //$log.log(rgn.data.b64.split(',')[1]);
        }

        r.readAsDataURL(f); //once defined all callbacks, begin reading the file

    };

    //delete file//
    rgn.deleteFile = function(currentFile) {
        FileUpload.uploadFiles.one(currentFile.RichTextEditorAttachmentID).remove().then(function (response) {
            $log.log("File deleted successfully", response);
            getUploadedFiles();
        }, function(err) {
            $log.log("Error while deleting file", err);
        });
    }




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