<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventCalendar.ascx.cs" Inherits="FutureAviator.UserControls.EventCalendar" %>
<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnViewDetails" EventName="Click" />
        <%--<asp:PostBackTrigger ControlID="btnLogin" />--%>
        <%--<asp:AsyncPostBackTrigger ControlID="btnLogin" EventName="Click" />--%>
        <%--<asp:AsyncPostBackTrigger ControlID="btnVolunteerEnroll" />
        <asp:AsyncPostBackTrigger ControlID="btnAttendEnroll" EventName="Click" />--%>
    </Triggers>
    <ContentTemplate>
        <%--<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>--%>

        <script type="text/javascript">
            function ShowMap() {
                try {
                    var lat = $("#cphMain_eventCal1_hdLatitude").val();
                    var lng = $("#cphMain_eventCal1_hdLongitude").val();
                    var venue = $("#cphMain_eventCal1_hdVenue").val();
                    if (lat == "" && lng == "") {
                        $("#cphMain_eventCal1_dvMap").val("No maps to display.");
                        //alert("No maps to display.");
                        return false;
                    }
                    var mapOptions = {
                        center: new google.maps.LatLng(lat, lng),
                        zoom: 13,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    var infoWindow = new google.maps.InfoWindow();

                    var map = new google.maps.Map(document.getElementById("cphMain_eventCal1_dvMap"), mapOptions);

                    //var data = markers[i]
                    var myLatlng = new google.maps.LatLng(lat, lng);
                    var marker = new google.maps.Marker({
                        position: myLatlng,
                        map: map,
                        title: venue
                    });
                    (function (marker) {
                        google.maps.event.addListener(marker, "click", function (e) {
                            infoWindow.setContent(venue);
                            infoWindow.open(map, marker);
                        });
                    })(marker);
                } catch (e) {
                    //alert(e.message);
                }

            }
        </script>

        <style type="text/css">
            .round-corners {
                border-radius: 50%;
            }

            td {
                /*border: none;*/
                border-bottom: none;
                font-size: 30px;
                width: auto;
            }

            th {
                text-align: center;
                width: 80px;
            }

            .buttons {
                height: 60px;
                font-size: 22px;
                background-color: #209793;
                color: white;
                text-wrap: none;
                border: none;
            }

            .uppercase {
                text-transform: uppercase;
            }

            .activeEvents {
                background-color: #209793;
                color: white;
                display: inline-block;
                font-size: 30px !important;
                line-height: 2.5em;
                border-right: 1px solid #fff;
            }

            .InactiveEvents {
                background-color: #fff;
                color: white;
                /*border-radius: 50%;*/
            }

            .selectedEvent {
                background-color: #33CCFF;
                color: white;
                line-height: 2.3em;
                font-size: 30px !important;
                border-right: 1px solid #fff;
            }

            .oldEvents {
                background-color: lightcoral;
                color: white;
                /*border-radius: 50%;*/
                display: inline-block;
                font-size: 30px !important;
                line-height: 2.5em;
                border-right: 1px solid #fff;
            }

            .eventName {
                /*text-transform: capitalize;*/
                font-size: 35px;
                font-weight: 500;
                /*color: #999;*/
            }

            .eventDate {
                /*text-transform: capitalize;*/
                font-size: 28px;
                color: #9ba8aa;
            }

            .venueDetails {
                text-transform: capitalize;
                font-size: 28px;
                color: #9ba8aa;
            }

            .SuccessMessage {
                background-color: green;
                color: white;
                text-transform: capitalize;
            }

            .ErrorMessage {
                background-color: red;
                color: white;
                text-transform: capitalize;
            }

            .InfoMessage {
                background-color: darkorange;
                color: white;
                text-transform: capitalize;
            }
        </style>

        <style type="text/css">
            /* Mask for background, by default is not display */
            #cphMain_eventCal1_Calendar1 th {
            }

            #cphMain_eventCal1_Calendar1 td {
                height: 80px !important;
                width: 80px !important;
            }

            #mask {
                display: none;
                background: #000;
                position: fixed;
                left: 0;
                top: 0;
                z-index: 10;
                width: 100%;
                height: 100%;
                opacity: 0.8;
                z-index: 999;
            }

            /* You can customize to your needs  */
            .login-popup {
                display: none;
                background: #333;
                padding: 10px;
                border: 2px solid #ddd;
                float: left;
                font-size: 1.2em;
                position: fixed;
                top: 50%;
                left: 50%;
                z-index: 99999;
                box-shadow: 0px 0px 20px #999;
                /* CSS3 */
                -moz-box-shadow: 0px 0px 20px #999;
                /* Firefox */
                -webkit-box-shadow: 0px 0px 20px #999;
                /* Safari, Chrome */
                border-radius: 3px 3px 3px 3px;
                -moz-border-radius: 3px;
                /* Firefox */
                -webkit-border-radius: 3px;
                /* Safari, Chrome */;
            }

            img.btn_close {
                float: right;
                margin: -28px -28px 0 0;
            }

            fieldset {
                border: none;
            }

            form.signin .textbox label {
                display: block;
                padding-bottom: 7px;
            }

            form.signin .textbox span {
                display: block;
            }

            form.signin p, form.signin span {
                color: #999;
                font-size: 11px;
                line-height: 18px;
            }

            form.signin .textbox input {
                background: #666666;
                border-bottom: 1px solid #333;
                border-left: 1px solid #000;
                border-right: 1px solid #333;
                border-top: 1px solid #000;
                color: #fff;
                border-radius: 3px 3px 3px 3px;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                font: 13px Arial, Helvetica, sans-serif;
                padding: 6px 6px 4px;
                width: 200px;
            }

            form.signin input:-moz-placeholder {
                color: #bbb;
                text-shadow: 0 0 2px #000;
            }

            form.signin input::-webkit-input-placeholder {
                color: #bbb;
                text-shadow: 0 0 2px #000;
            }

            .button {
                background: -moz-linear-gradient(center top, #f3f3f3, #dddddd);
                background: -webkit-gradient(linear, left top, left bottom, from(#f3f3f3), to(#dddddd));
                background: -o-linear-gradient(top, #f3f3f3, #dddddd);
                filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#f3f3f3', EndColorStr='#dddddd');
                border-color: #000;
                border-width: 1px;
                border-radius: 4px 4px 4px 4px;
                -moz-border-radius: 4px;
                -webkit-border-radius: 4px;
                color: #333;
                cursor: pointer;
                display: inline-block;
                padding: 6px 6px 4px;
                margin-top: 10px;
                font: 12px;
                width: 214px;
            }

                .button:hover {
                    background: #ddd;
                }

            /*.newTextSize {
                font-size: 25px;
            }*/
        </style>

        <script type="text/javascript">
            function RemoveMask() {
                $('#mask , .login-popup').fadeOut(300, function () {
                    $('#mask').remove();
                });
                return false;
            }
            function BindEvents() {
                $(document).ready(function () {
                    $('#cphMain_eventCal1_btnVolunteerEnroll').click(function () {
                        var userID = parseInt($('#cphMain_eventCal1_hdUserID').val(), 10);

                        if (userID == 0 || isNaN(userID)) {
                            //Getting the variable's value from a link 
                            var loginBox = $('#login-box');
                            ShowLoginPopup();

                            return false;
                        }
                        else {
                            $('#cphMain_eventCal1_hdAttendType').val("V");
                            //alert($('#cphMain_eventCal1_hdAttendType').val());
                        }
                    });

                    $('#cphMain_eventCal1_btnAttendEnroll').click(function () {
                        var userID = parseInt($('#cphMain_eventCal1_hdUserID').val(), 10);

                        if (userID == 0 || isNaN(userID)) {
                            //Getting the variable's value from a link 
                            var loginBox = $('#login-box');
                            ShowLoginPopup();


                            return false;
                        }
                        else {
                            $('#cphMain_eventCal1_hdAttendType').val("A");
                            //alert($('#cphMain_eventCal1_hdAttendType').val());
                        }
                    });



                });
            }
        </script>

        <table style="width: 100%; height: 100%" class="eventTable">
            <tr>
                <td style="width: 40%">
                    <asp:Calendar ID="Calendar1" OnDayRender="Calendar1_DayRender" runat="server" BorderStyle="None" OnSelectionChanged="Calendar1_SelectionChanged" Width="95%" Height="360px" BackColor="White">
                        <DayHeaderStyle Font-Size="18px" Font-Bold="false" ForeColor="#000" />
                        <DayStyle Height="80px" Width="80px" Font-Size="15px" />
                        <SelectedDayStyle CssClass="selectedEvent" />
                        <TitleStyle BackColor="White" Font-Bold="true" Font-Size="30px" ForeColor="Gray" CssClass="uppercase" />
                    </asp:Calendar>

                    <div class="row">
                        <div class="col-xs-2  col-lg-1 pull-left activeLedgend">
                            &nbsp;
                        </div>
                        <div class="col-lg-3 pull-left newTextSize">
                            <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventTextActive").ToString() : GetGlobalResourceObject("Arabic", "EventTextActive").ToString() %>
                        </div>
                    </div>

                    <div class="row ">
                        <div class="col-xs-2  col-lg-1 pull-left expiredLedgend">
                            &nbsp;
                        </div>
                        <div class="col-lg-3 pull-left newTextSize">
                            <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventTextOld").ToString() : GetGlobalResourceObject("Arabic", "EventTextOld").ToString() %>
                        </div>
                    </div>

                </td>
                <td style="border-left: 1px solid black; padding: 2%; width: 60%">
                    <table style="width: 100%; height: 100%; background-color: white">
                        <tr>
                            <td runat="server" id="eventTitleTd">
                                <asp:Label ID="lblEventsHeader" runat="server" CssClass="eventName"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEventDate" runat="server" CssClass="eventDate text-left"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEventVenue" runat="server" CssClass="venueDetails"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="dvMap" style="width: 100%; height: 200px;" runat="server">
                                </div>
                                <input id="hdLatitude" type="hidden" runat="server" />
                                <input id="hdLongitude" type="hidden" runat="server" />
                                <input id="Hidden1" type="hidden" runat="server" />
                                <input id="hdVenue" type="hidden" runat="server" />
                                <input id="hdFileNameArabic" type="hidden" runat="server" />
                                <input id="hdFileNameEnglish" type="hidden" runat="server" />
                                <input id="hdUserID" type="hidden" runat="server" />
                                <input id="hdEventID" type="hidden" runat="server" />
                                <input id="hdAttendType" type="hidden" runat="server" />
                                <input id="hdDetailType" type="hidden" runat="server" />
                                <input id="hdExternalURL" type="hidden" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <center>
                            <script type="text/javascript">
                                Sys.Application.add_load(BindEvents);
                                Sys.Application.add_load(ShowMap);
                            </script>
                        <asp:Button ID="btnViewDetails" runat="server" OnClick="btnViewDetails_Click" Visible="False" cssClass="buttons" />&nbsp;
                        <asp:Button ID="btnVolunteerEnroll" runat="server" Visible="False" cssClass="buttons" OnClick="btnAttendEnroll_Click" />                        
                        &nbsp;
                        <asp:Button ID="btnAttendEnroll" runat="server" Visible="False" cssClass="buttons" OnClick="btnAttendEnroll_Click" />

                        </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblErrDesc" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>


<div id="login-box" class="login-popup">
    <a href="#" class="close">
        <img src="assets/images/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>
</div>
