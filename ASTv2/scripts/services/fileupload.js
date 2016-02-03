'use strict';

astApp.factory('FileUpload', ['$log', 'Restangular', function ($log, Restangular) {
    return {
        uploadFiles: Restangular.service('fileupload'),
        getFiles: Restangular.service('fileupload/GetRegionFiles')
    }
}]);