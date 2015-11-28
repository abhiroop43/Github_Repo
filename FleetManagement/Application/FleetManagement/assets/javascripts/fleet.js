/// <reference path="jquery.min.js" />
function SetAdminMenu() {
    var documentUrl = $.trim(window.document.URL.split('/')[window.document.URL.split('/').length - 1]);
    var isSet = false;
    $("#main-menu a").each(function (a, href) {
        if (!isSet) {
            var linkObject = $(this);
            var link = "" + href;
            //alert(link);
            var linkPageName = $.trim(link.split('/')[link.split('/').length - 1]);
            //alert('Link Page: ' + linkPageName + ' docURL: ' + documentUrl);
            if (documentUrl === linkPageName) {
                if ($(linkObject).parents(".sub-menu").length > 0) {
                    //alert('in if block');
                    $(linkObject).addClass("active").parents("ul.sub-menu:first").show().parents("li:first").addClass("open").find(".arrow").addClass("open");
                    isSet = true;
                }
                else {
                    //alert('in else block');
                    $(linkObject).parents("li:first").addClass("active");
                    isSet = true;
                }
            }
        }
    });
}

$(document).ready(function() {
    SetAdminMenu();
});