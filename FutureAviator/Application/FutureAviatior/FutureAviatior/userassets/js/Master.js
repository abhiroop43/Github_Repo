$(window).load(function () {
    var topMenu = $("#top-menu"),
   topMenuHeight = topMenu.outerHeight() + 10,
   menuItems = topMenu.find("a"),

 scrollItems = menuItems.map(function () {
     var item = $($(this).attr("href"));
     if (item.length) { return item; }
 });
    $(window).scroll(function () {
        var fromTop = $(this).scrollTop() + topMenuHeight;
        var cur = scrollItems.map(function () {
            if ($(this).offset().top < fromTop)
                return this;
        });
        cur = cur[cur.length - 1];

        var id = cur && cur.length ? cur[0].id : "";
        menuItems.parent().removeClass("active").end().filter("[href=#" + id + "]").parent().addClass("active");
    });

    //Navigation auto hide menubar........
    $(document).on('click', function (e) {
        $("#parentMenu").collapse("hide");
    });

    $(".homeScreen").on('click', function (e) {
        $("#parentMenu").collapse("hide");
    });

});

function SetPositionOfLoginText() {

    if (IsApple()) {
        $("#cphMain_hypLogin").addClass("padding4");
    }
    else
    {
        $("#cphMain_hypLogin").removeClass("padding4");
    }
}


$(window).load(function () {
    SetNavigationPosition();
    SetParallaxheight();
    SetMainNavigation();
    SetNewsMarquee();
    SetPortfolio();
    SetTtickyNavigation();
    SetLoader();
    SetCalander();
    setHeight();
    RemoveBlankParagraphs();
    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true
    });
    setTimeout(function () {
        $("#loader-wrapper").fadeOut();
        initialize();
        SetPositionOfLoginText();
        if (IsMobile()) {
            // $("#testimonial-area p").removeAttr("class");
        }
    }, 50);

    //$("img").lazyload({
    //    effect: "fadeIn"
    //});

    // $("p").addClass("TextAlighLeft");
    $("blockquote").removeAttr("style").addClass("TextAlighLeft");
});
function setHeight() {
    var max = -1;
    $("#testimonial-area .item").each(function () {
        var h = $(this).height();
        max = h > max ? h : max;
    });

    $("#testimonial-area").find(".testimonial").attr("style", "min-height:" + max + "px");

}
function SetNavigationPosition() {
    if (IsMobile())
        $('#StickyMain').removeAttr('style');
}
function SetParallaxheight() {
    if (IsMobile()) {
        $(".parallax-height").attr("style", "height:20%;");
    }
    else {
        $('.parallax-height').removeAttr('style');
    }
}

function RemoveBlankParagraphs() {
    $('p').filter(function () { return $.trim(this.innerHTML) == "" }).remove();

    // Without trimming white space
    $('p').filter(function () { return this.innerHTML == "" }).remove();
}
function SetCalander() {
    if ($.trim($("#cphMain_eventCal1_Calendar1").find("tr:last").text() == "")) {
        $("#cphMain_eventCal1_Calendar1").find("tr:last").remove();
    }
}
function SetLoader() {

}
function ShowNewsDetail(NewsID, NewsTitle) {
    $("#newsIframe").attr("src", "/NewsDetails.aspx?id=" + NewsID);
    $("#ModalNewsTitle").html(decodeURIComponent(NewsTitle));
    $('#modalNews').modal('show');
}

function ShowPressReleaseDetail(ID, RlsHeader) {
    $("#newsIframe").attr("src", "PressReleaseDetails.aspx?ID=" + ID);
    $("#ModalNewsTitle").html(RlsHeader);
    $('#modalNews').modal('show');
}

function ShowLoginPopup() {
    $('#modalLogin').modal('show');
}
function LoginSuccessCallBack() {
    document.location.reload();
}

function SetTtickyNavigation() {
    var divHeight = $('#homePageSliderDiv').height();
    //$("#tempDiv").html("Home PageSlider Div : " + divHeight);



    if (!IsMobile()) {
        $('.Stickynav').scrollToFixed({});
        setTimeout(function () {
            if (IsMobile()) {
                $('.Stickynav').css("style:width:100%;");
            }
        }, 500);
    }



    $(window).on('scroll', function (e) {
        if ($('.Stickynav').css('position') === 'fixed') {
            $('.secondaryLogo').fadeIn();
        } else {
            $('.secondaryLogo').fadeOut();
        }

        if (IsMobile()) {
            //$("#tempDiv").html("Mobile : " + $(this).scrollTop());


            if ($(window).scrollTop() > divHeight) {
                $('#StickyMain').removeAttr('style');
                $('.Stickynav').attr('style', "z-index: 1000; width: 100%; position: fixed; top: 0px; left: 0px;");

            }
            if ($(window).scrollTop() < (divHeight + 1)) {
                $('#StickyMain').removeAttr('style');
                $('.Stickynav').removeAttr('style');
                // $('#StickyMain').attr('style', "z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;");
            }
        } else {
           

            if ($(window).scrollTop() > 80) {
                $('#StickyMain').removeAttr('style');
            }
            if ($(window).scrollTop() < 80) {
                $('#StickyMain').removeAttr('style');
                $('#StickyMain').attr('style', "z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;");
            }

            //$('#StickyMain').removeAttr('style');
            //$('.Stickynav').attr('style', "z-index: 1000; width: 100%; position: fixed; top: 0px; left: 0px;");
        }


        /*
        else {
            $('.Stickynav').scrollToFixed({});
            setTimeout(function () {
                if (IsMobile()) {
                    $('.Stickynav').css("style:width:100%;");
                }
            }, 500);
        }
        */
    });





    //summaries.each(function (i) {
    //    var summary = $(summaries[i]);
    //    var next = summaries[i + 1];

    //    summary.scrollToFixed({
    //        marginTop: $('.header').outerHeight(true) + 10,
    //        limit: function () {
    //            var limit = 0;
    //            if (next) {
    //                limit = $(next).offset().top - $(this).outerHeight(true) - 10;
    //            } else {
    //                limit = $('.footer').offset().top - $(this).outerHeight(true) - 10;
    //            }
    //            return limit;
    //        },
    //        zIndex: 999
    //    });
    //});
    //  $('.footer').scrollToFixed( { bottom: 0, limit: $('.footer').offset().top } );
}





/* Commit temp by bhatti.........
function SetTtickyNavigation()
{
    $("#tempDiv").html("ON load call");
    try
    {
        if (!IsMobile()) {
            //if ($(window).scrollTop() > 80) {
            //    $('#StickyMain').removeAttr('style');
            //}
            //if ($(window).scrollTop() < 81) {
            //    $('#StickyMain').attr('style', "z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;");
            //}
            $('#StickyMain').removeAttr('style');
            $('.Stickynav').attr('style', "z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;");
        }

        $(window).scroll(function () {
            $("#tempDiv").html("<div>Handler for .scroll() called.</div>");
        });


        $(window).on('scroll', function (e) {

           // console.log(e);
            $("#tempDiv").html($(this).scrollTop());
            
            if ($('.Stickynav').css('position') === 'fixed') {
                $('.secondaryLogo').fadeIn();
            } else {
                $('.secondaryLogo').fadeOut();
            }

            if (!IsMobile()) {
                //if ($(window).scrollTop() > 80) {
                //    $('#StickyMain').removeAttr('style');
                //}
                //if ($(window).scrollTop() < 81) {
                //    $('#StickyMain').attr('style', "z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;");
                //}
                $('#StickyMain').removeAttr('style');
                $('.Stickynav').attr('style', "z-index: 1000; width: 100%; position: fixed; top: 0px; left: 0px;");
            }
        });
    } catch (err) { alert('error'); }

    $('.Stickynav').scrollToFixed({});

    setTimeout(function () {
        if (IsMobile()) {
            $('.Stickynav').css("style:width:100%;");
        }
    }, 500);


    //summaries.each(function (i) {
    //    var summary = $(summaries[i]);
    //    var next = summaries[i + 1];

    //    summary.scrollToFixed({
    //        marginTop: $('.header').outerHeight(true) + 10,
    //        limit: function () {
    //            var limit = 0;
    //            if (next) {
    //                limit = $(next).offset().top - $(this).outerHeight(true) - 10;
    //            } else {
    //                limit = $('.footer').offset().top - $(this).outerHeight(true) - 10;
    //            }
    //            return limit;
    //        },
    //        zIndex: 999
    //    });
    //});
    //  $('.footer').scrollToFixed( { bottom: 0, limit: $('.footer').offset().top } );
}
*/


function SetPortfolio() {
    var $container = $('.portfolioContainer');
    $container.isotope({
        filter: '*',
        animationOptions: {
            duration: 750,
            easing: 'linear',
            queue: false
        }
    });

    $('.portfolioFilter a').click(function () {
        $('.portfolioFilter .current').removeClass('current');
        $(this).addClass('current');
        var selector = $(this).attr('data-filter');
        $container.isotope({
            filter: selector,
            animationOptions: {
                duration: 750,
                easing: 'linear',
                queue: false
            }
        });
        return false;
    });
}

function SetMainNavigation() {
    $('ul.nav  a[href*=#]:not([href=#])').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top
                }, 1000);
                return false;
            }
        }
    });


    $('.bottomLink a[href*=#]:not([href=#])').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top
                }, 1000);
                return false;
            }
        }
    });
}
function SetNewsMarquee() {
    createMarquee({
    });

    //example of overwriting defaults: 

    // createMarquee({
    // 		duration:30000, 
    // 		padding:20, 
    // 		marquee_class:'.example-marquee', 
    // 		newsstickcont_class: '.example-newsstickcont', 
    // 		sibling_class: '.example-sibling', 
    // 		hover: false});
    // });
}
//LoadingText
function ResetColoursAndShowLoading() {
    $('#myModalLabel').html(LoadingText);
    $('#ContactUsMsgBody').css("background-color", "");
    $('#ContactUsMsgBody').html("");
}
function SubmitContactUsForm() {

    $('#ContactUsMsgBody').css("background-color", "");
    var name = $('#name').val();
    var email = $('#youremail').val();
    var msg = $('#ContactRequestMsg').val();
    if (ValidateContactForm(name, email, msg)) {
        ResetContactForm();
        ResetColoursAndShowLoading();
        $.ajax(
                {
                    type: "POST",
                    url: "Default.aspx/SendContactRequest",
                    data: "{'name' : '" + name + "', 'email' : '" + email + "', 'msg' : '" + msg + "'}",
                    //data: { name: name, email: email },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (msg) {
                        console.log(msg.d);
                        if (msg.d == 'success') {
                            $('#myModalLabel').html(InvalidInputSuccess);
                            $('#ContactUsMsgBody').css("background-color", "lime");
                            $('#ContactUsMsgBody').html(SubmitSuccessMessage);
                            ResetContactForm();
                        }
                        else {
                            $('#myModalLabel').html(InvalidInputError);
                            $('#ContactUsMsgBody').css("background-color", "red");
                            $('#ContactUsMsgBody').html(SubmitErrorMessage);
                        }
                    },
                    error: function (x, e) {
                        //alert("The call to the server side failed. " + x.responseText);
                        $('#myModalLabel').html(InvalidInputError);
                        $('#ContactUsMsgBody').css("background-color", "red");
                        $('#ContactUsMsgBody').html(SubmitErrorMessage);
                    }
                }
            );
        //return false;
    }
    ResetContactForm();
}

function ValidateContactForm(name, email, msg) {
    if ($.trim(name) == '') {
        $('#myModalLabel').html(InvalidInputWarning);
        $('#ContactUsMsgBody').css("background-color", "yellow");
        $('#ContactUsMsgBody').html(InvalidName);
        //InvalidName
        return false;
    }

    if ($.trim(email) == '') {
        $('#myModalLabel').html(InvalidInputWarning);
        $('#ContactUsMsgBody').css("background-color", "yellow");
        $('#ContactUsMsgBody').html(InvalidEmail);
        //InvalidEmail
        return false;
    }

    if (!ValidateEmail($.trim(email))) {
        $('#myModalLabel').html(InvalidInputWarning);
        $('#ContactUsMsgBody').css("background-color", "yellow");
        $('#ContactUsMsgBody').html(InvalidEmail);

        return false;
    }

    if ($.trim(msg) == '') {
        $('#myModalLabel').html(InvalidInputWarning);
        $('#ContactUsMsgBody').css("background-color", "yellow");
        $('#ContactUsMsgBody').html(InvalidMessage);
        //InvalidMessage
        return false;
    }
    ResetContactForm();
    return true;
}

function ValidateEmail($email) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    return emailReg.test($email);
}

function ResetContactForm() {
    $('#name').val('');
    $('#youremail').val('');
    $('#ContactRequestMsg').val('');
}

/*privacy policy*/
function ShowPrivacyPolicy() {
    $('#modalPrivacyPolicy').modal('show');
}

function IsMobile() {
    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))
        return true;
    else
        return false;
}



function IsApple() {
    if (/iPhone|iPad|iPod|Mac/i.test(navigator.userAgent))
        return true;
    else
        return false;
}