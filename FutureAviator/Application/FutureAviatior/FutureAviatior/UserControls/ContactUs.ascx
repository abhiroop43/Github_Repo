<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.ascx.cs" Inherits="FutureAviator.UserControls.ContactUs" %>


<style>
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

    .Inline {
        display: inline-block;
    }

    .NoResize {
        resize: none;
    }
</style>
<div class="headingtxt">
    <h1 id="contactus" runat="server">CONTACT US</h1>
</div>
<div class="aligncenter">

    <p class="lead" id="cmsContactUsDesc" runat="server">Kindly submit your information in the form provided below and we will revert at the earliest</p>

    <div class="row">
        <div class="form-inline col-lg-6 col-lg-offset-3">
            <div class="row">
                <div class="form-group col-lg-6">
                    <label for="name"></label>
                    
                    <asp:TextBox ID="txtName" runat="server" Style="width: 100%;" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group col-lg-6">
                    <label for="youremail"></label>
                    <asp:TextBox ID="txtEmail" runat="server" Style="width: 100%;" MaxLength="70" type="email" CssClass="form-control"></asp:TextBox>
                </div>
            </div> 
            <div class="row">
                <div class="col-lg-12">
                    <div class="">
                        <label id="smsid" for="yourmessage"></label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" ValidationGroup="1" placeholder="Your Message" CssClass="form-control" Style="width: 100%;" Rows="5"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <asp:Button ID="btnSubmit" style="margin-top:10px;" runat="server" ValidationGroup="1" OnClick="btnSubmit_Click" class="btn btn-gclr btn-lg"></asp:Button>
                </div>
            </div>

            <asp:Label ID="lblResponse" runat="server"></asp:Label>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">THANK YOU</h4>
                        </div>
                        <div class="modal-body">
                            Thank you for your inputs we will get back to you shortly
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    

</div>
