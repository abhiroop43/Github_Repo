<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_RegisterJob.ascx.cs" Inherits="FutureAviator.UserControls.Admin_RegisterJob" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" runat="server" Text="Register A Job"></asp:Label>
            </h2>
        </header>

        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-9 col-xs-10">

                    <div class="form-group">
                        <label class="form-label" for="field-1">Job Title (English)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtJobTitleEnglish" required CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="field-1">Job Title (Arabic)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtJobTitleArabic" CssClass="form-control" required runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Select Industry</label>
                        <div class="controls">
                            <asp:DropDownList ID="ddlIndustry" CssClass="form-control m-bot15" required runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Select Location</label>
                        <div class="controls">
                            <asp:DropDownList ID="ddlLocation" CssClass="form-control m-bot15" required runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Select Job Expiry Date</label>
                        <div class="controls">
                            <asp:Calendar ID="txtExpiryDate" runat="server"></asp:Calendar>
                        </div>
                    </div>

<%--                    <div class="form-group">
                        <label class="form-label" for="field-1">Select Job Expiry Date</label>
                        <div class="controls">
                            <input class="form-control datepicker col-md-4" type="text" data-format="D, dd MM yyyy" value="Mon, 02 February 2015">
                            <span style="padding:9px 12px;" class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </span>
                        </div>
                    </div>--%>


                    <div class="form-group">
                        <label class="form-label" for="field-1">Keywords (comma separated)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtKeywords" class="form-control input-tags" data-role="tagsinput" required runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Job Description (English)</label>
                        <div class="controls">
                            <%--<FTB:FreeTextBox ID="txtJobDescriptionEnglish" runat="server" />--%>
                            <textarea class="nicinstance" style="width: 100%; height: 100px" id="txtJobDescriptionEnglish" runat="server"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Job Description (Arabic)</label>
                        <div class="controls">
                            <%--<FTB:FreeTextBox ID="txtJobDescriptionArabic" runat="server" />--%>
                            <textarea class="nicinstance" style="width: 100%; height: 100px" id="txtJobDescriptionArabic" runat="server"></textarea>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="form-label">
                            <span class="iCheck">
                                <asp:CheckBox ID="chkbxIsActive" Checked="true" runat="server"></asp:CheckBox>
                            </span>
                            <span>Is Active?</span>
                        </label>
                    </div>



                    <div id="ButtonSaveArea" runat="server" class="form-group">
                        <asp:Button ID="btnAddJob" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnAddJob_Click" />
                    </div>

                    <div id="UpdateButtonArea" runat="server" visible="false" class="pull-right">
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                        <a href="RegiseredJobs.aspx" class="btn">Cancel</a>
                    </div>
                    <asp:HiddenField ID="hdnJobTitleTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnJobDescriptionTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnJobID" runat="server" Value="0" />
                </div>
            </div>


        </div>

    </section>
</div>

