$(document).ready(function () {
    $('.careerDetails').fadeOut();
    //$('div.teamImage').removeClass('active').fadeTo('fast', .4)

    //$('div.teamImage').on({
    //mouseenter: function () {
    //    //stuff to do on mouse enter
    //	$(this).fadeTo('fast', 1)
    //},
    //mouseleave: function () {
    //    //stuff to do on mouse leave
    //	$(this).fadeTo('fast', .4)
    //}
    //});


    $('.careerLink').click(function (e) {
        var fun = this;
        $('#careersBody .teamImage').removeClass('active').fadeTo('fast', .4)

        $(fun).closest('#careersBody .teamImage').addClass('active').fadeTo('fast', 1)

        $('.careerDetails:visible').fadeOut('fast', function () {
            $('.' + $(fun).attr('id')).fadeIn();
        });

        if ($('.careerDetails:visible').length == 0)
            $('.' + $(fun).attr('id')).fadeIn();

        return false;
    })
});


