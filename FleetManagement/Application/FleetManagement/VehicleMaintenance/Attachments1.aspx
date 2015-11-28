<%@ Page Language="c#" Trace="false" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script language="c#" runat="server">

	private void Page_Load(object sender, System.EventArgs e) {
        // code changes from here for the session timeout
        if (Session["SessionLogId"] == null)
        {
            Response.Write("You session has ended. Kindly refresh the page. All unsubmitted information needs to be submit again.");
            Response.End();
        }
        // code changes till here for the session timeout
		if (!Page.IsPostBack) {
			// Open our database connection to the table with the BLOB field and fill our datagrid
            //SqlConnection oConn = new SqlConnection("Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=WebLeave;User Id=webleave;Password=pass@word9;");
            //SqlConnection oConn = new SqlConnection("Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=sa;Password=Pass@gcaa!@#;");
            SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString);
            if (Request.QueryString["Action"] != null)
            {
                if (Request.QueryString["Action"].ToString() == "9")
                {
                    //SqlCommand oComm = new SqlCommand("UPDATE GCAA_ESS_Leave_Attachments_VehicleMaintenance Where  DOC_ID = " + Request.QueryString["FILEID"], oConn);
                    SqlCommand oComm = new SqlCommand("UPDATE GCAA_ESS_Leave_Attachments_VehicleMaintenance SET REQUESTID = '*' + REQUESTID Where  DOC_ID = " + Request.QueryString["FILEID"], oConn);
                    oConn.Open();
                    oComm.ExecuteNonQuery();

                }
            }

            BindDataGrid(oConn, AttachedFiles, "SELECT DOC_ID AS FILE_ID, FILENAME AS FILE_NAME, DATALENGTH(DOCUMENT) AS FILE_SIZE, REQUESTID as [Request Id] FROM GCAA_ESS_Leave_Attachments_VehicleMaintenance FILES Where REQUESTID = '" + Request.QueryString["ID"] + "'");
            
            btnDownload_Click(sender, e);
            Session.Add("AccountCode", Request.QueryString["list"]);
		}
        btnUpload.Attributes.Add("onClick", "return validateFileUpload('" + filUpload.ClientID + "')");
	}
	
	private void btnUpload_Click(object sender, System.EventArgs e) {
		// If no file was uploaded then you probably want to inform the user to select a file
		// before clicking the upload button.
		if (filUpload.PostedFile != null) {
			// Get a reference to the uploaded file
			HttpPostedFile filPosted = filUpload.PostedFile;
			int intFileLength = System.Convert.ToInt32(filPosted.ContentLength);
			
			// Ensure that there were contents to the file. Exit out of the function if there is no content.
			if (intFileLength == 0) {
				return;
			}
			
			// Open our database connection to the table with the BLOB field
            //SqlConnection oConn = new SqlConnection("Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=sa;Password=Pass@gcaa!@#;");
            SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString);
            SqlDataAdapter oDA = new SqlDataAdapter("SELECT DOC_ID AS FILE_ID, FILENAME AS FILE_NAME, DOCUMENT as FILE_DATA, REQUESTID as REQUESTID  FROM GCAA_ESS_Leave_Attachments_VehicleMaintenance FILES Where REQUESTID = '" + Request.QueryString["ID"] + "'", oConn);
			SqlCommandBuilder oCB = new SqlCommandBuilder(oDA);
			DataSet ds = new DataSet();
			DataRow dr;
			
			// Fill the dataset with the schema but not the data
			oDA.MissingSchemaAction = MissingSchemaAction.AddWithKey;
			oConn.Open();
			oDA.FillSchema(ds, SchemaType.Source, "FILES");
			
			// This may not be necessary
			byte[] byteData = new byte[intFileLength];
			filPosted.InputStream.Read(byteData, 0, intFileLength);
			
			// Create a new row to insert into the table
			dr = ds.Tables["FILES"].NewRow();
			dr["FILE_ID"] = 1; // this should not be needed ... it's a sequence but will not allow nulls? so the 1 is a placeholder
			dr["FILE_NAME"] = System.IO.Path.GetFileName(filPosted.FileName);
			dr["FILE_DATA"] = byteData;
            dr["REQUESTID"] = Request.QueryString["ID"];
			
			// Append the new row to the dataset
			ds.Tables["FILES"].Rows.Add(dr);
			
			// Update the table using our dataset against our data adapter
			oDA.Update(ds, "FILES");
			
			// Close our connection
			oConn.Close();
			
			// Refresh the contents to the datagrid
            BindDataGrid(oConn, AttachedFiles, "SELECT DOC_ID AS FILE_ID, FILENAME AS FILE_NAME, DATALENGTH(DOCUMENT) AS FILE_SIZE, REQUESTID as [Request Id] FROM GCAA_ESS_Leave_Attachments_VehicleMaintenance FILES Where REQUESTID = '" + Request.QueryString["ID"] + "'");
            btnDownload_Click(sender, e);
		}
	}
	
	private void btnDownload_Click(object sender, System.EventArgs e) {
		
		// If there were files selected then create the ZIP file for download
        //if (strIDs.Length > 0) {
			// Connect to the database and grab the selected documents
        //SqlConnection oConn = new SqlConnection("Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=sa;Password=Pass@gcaa!@#;");
        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString);
			
			// Open the database connection and fill the dataset
			oConn.Open();
            SqlCommand Comm = new SqlCommand("SELECT FILENAME AS FILE_NAME, DOCUMENT FILE_DATA, DATALENGTH(DOCUMENT) AS FILE_SIZE, REQUESTID as [Request Id] FROM GCAA_ESS_Leave_Attachments_VehicleMaintenance as FILES Where REQUESTID = '" + Request.QueryString["ID"] + "'", oConn);//where DOC_ID IN (" + strIDs.Substring(0, strIDs.Length - 1) + ")", oConn);
            SqlDataReader myReader = Comm.ExecuteReader(CommandBehavior.SequentialAccess);

            while (myReader.Read())
            {
                FileStream fs;                          // Writes the BLOB to a file (*.bmp).
                BinaryWriter bw;                        // Streams the BLOB to the FileStream object.
                int bufferSize = 100;                   // Size of the BLOB buffer.
                byte[] outbyte = new byte[bufferSize];  // The BLOB byte[] buffer to be filled by GetBytes.
                long retval;                            // The bytes returned from GetBytes.
                long startIndex = 0;                    // The starting position in the BLOB output.

                // Create a file to hold the output.
                fs = new FileStream(Server.MapPath("./Download/") + myReader["FILE_NAME"].ToString(),
                                    FileMode.OpenOrCreate, FileAccess.Write);
                bw = new BinaryWriter(fs);

                // Reset the starting byte for the new BLOB.
                startIndex = 0;

                // Read the bytes into outbyte[] and retain the number of bytes returned.
                retval = myReader.GetBytes(1, startIndex, outbyte, 0, bufferSize);

                // Continue reading and writing while there are bytes beyond the size of the buffer.
                while (retval == bufferSize)
                {
                    bw.Write(outbyte);
                    bw.Flush();

                    // Reposition the start index to the end of the last buffer and fill the buffer.
                    startIndex += bufferSize;
                    retval = myReader.GetBytes(1, startIndex, outbyte, 0, bufferSize);
                }

                // Write the remaining buffer.
                bw.Write(outbyte, 0, (int)retval);
                bw.Flush();

                // Close the output file.
                bw.Close();
                fs.Close();

                
			}
			// Close the database connection
			oConn.Close();
		
		}
    //}
	
	private void lblFileSize_DataBinding(object sender, System.EventArgs e) {
      
		// Formatting the label to show the file size in kilobytes
        Label lblSize = (Label)sender;
        lblSize.Text = String.Format("{0:#,###}", System.Math.Ceiling(System.Convert.ToDouble(lblSize.Text) / 1024));
	}

    
    private void BindDataGrid(SqlConnection o, GridView d, string sql)
    {
		SqlCommand oComm = new SqlCommand(sql, o);
        if (o.State != ConnectionState.Open )
        {o.Open();}		
		d.DataSource = oComm.ExecuteReader(CommandBehavior.CloseConnection);
		d.DataBind();
	}

    protected void AttachedFiles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.HorizontalAlign = HorizontalAlign.Center;
        e.Row.VerticalAlign = VerticalAlign.Middle;

        e.Row.Cells[0].Visible = false;
        //e.Row.Cells[1].Visible = false;

        if (e.Row.RowType == DataControlRowType.DataRow)
        { 
          HtmlAnchor _anchor = new HtmlAnchor();
          string dtItem = DataBinder.Eval(e.Row.DataItem, "File_Name").ToString();
          string requestID = DataBinder.Eval(e.Row.DataItem, "Request Id").ToString();

          _anchor =(HtmlAnchor) e.Row.FindControl("_download");
          dtItem = DataBinder.Eval(e.Row.DataItem, "File_Name").ToString();
          _anchor.HRef = "./Download/" + dtItem.Trim();
          _anchor.Target = "_blank";

          _anchor = (HtmlAnchor)e.Row.FindControl("_delete");
          dtItem = DataBinder.Eval(e.Row.DataItem, "FILE_ID").ToString();
          _anchor.HRef = "Attachments1.aspx?Action=9&FILEID=" + dtItem.Trim() + "&ID=" + requestID + "&list=" +  Session["AccountCode"];
        }
    }
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Vehicle Maintenance - Attachment(s)</title>
		<script language="javascript" type="text/javascript">
			// a simple function to find toggle all of the checkboxes in a form
			function checkAll(o) {
				for (var i = 0; i < document.myForm.elements.length; i++) {
					if (document.myForm.elements[i].type == "checkbox") {
						document.myForm.elements[i].checked = o.checked;
					}
				}
}
			function validateFileName(obj) {
			    var str = new String();
			    var fileup = document.getElementById(obj);
			    str = fileup.value;
			    str = str.substring(str.lastIndexOf('\\') + 1).toLowerCase();
			    str = str.substring(0, str.lastIndexOf('.')).toLowerCase();
			    var strchar = new String();

			    for (var i = 0; i < str.length; i++) {
			        strchar = str.charAt(i);
			        if ((strchar.charCodeAt(0) >= 48 && strchar.charCodeAt(0) <= 57) ||
               (strchar.charCodeAt(0) >= 65 && strchar.charCodeAt(0) <= 90) ||
			   (strchar.charCodeAt(0) == 45 || strchar.charCodeAt(0) == 95) ||
               (strchar.charCodeAt(0) >= 97 && strchar.charCodeAt(0) <= 122)) {
			            //alert("valid");
			        }
			        else {
			            alert("File name is not suitable for uploading.\nFile name can contain only a-z, A-Z, -, _ and 0-9 characters !!!");
			            return false;
			        }
			    }
			}
			function validateFileUpload(obj) {

			    var fileName = new String();
			    var fileExtension = new String();

			    // store the file name into the variable
			    var fileup = document.getElementById(obj);
			    fileName = fileup.value;

			    if (validateFileName(obj) == false) {
			        return false;
			    }

        
        // extract and store the file extension into another variable
        //fileExtension = fileName.substr(fileName.length - 4, 4);
        fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        // array of allowed file type extensions
        var validFileExtensions = new Array("pdf", "jpg", "gif", "doc", "docx", "tiff", "tif");
        
        var flag = false;
        
        // loop over the valid file extensions to compare them with uploaded file
        for(var index = 0; index < validFileExtensions.length; index++){
            if(fileExtension.toLowerCase() == validFileExtensions[index].toString().toLowerCase()){
                flag = true;
            }
        }
        
        // display the alert message box according to the flag value
        if(flag == false){
            alert('Files with extension ".' + fileExtension.toUpperCase() + '" are not allowed.\n\nYou can upload the files with following extensions only:\n.pdf\n.jpg\n.gif\n.doc\n.docx\n.tiff\n.tif');
            return false;
        }
        else{
            //alert('File has valid extension.');
            return true;
        }
    }


		</script>
		<style type = "text/css">
			fieldset {
				cursor: default;
				font-family: Arial;
			}
			div {
				width: 600px;
			}
		    #filUpload
            {
                width: 316px;
            }
		</style>
	</head>
	<body>
		<form runat="server" id="myForm" name="myForm" method="post" enctype="multipart/form-data">
		
			<div align="center">
			<table width="600px">
			  <tr> 
			    <td align="center" class="" colspan="2" visible="false"
                    style="font-family: Calibri; font-weight: bold; background-color: #0099FF; color: #FFFFFF; font-size: 20px;">
                    Attachment(s) for Vehicle Maintenance </td>
			  </tr>
			
			  <tr> 
			    <td ><fieldset style="font-family: Calibri; font-weight: bold; font-size: 12px;">
					<legend>Select Files</legend>
					<input runat="server" id="filUpload" type="file">
					<asp:Button runat="server" id="btnUpload" OnClick="btnUpload_Click" 
                        Text="Attach" />
				</fieldset></td>
			  </tr>
			</table>
				
				<fieldset style="font-family: Calibri; font-weight: bold; font-size: 12px;">
					<legend>Attached Files</legend>
					<asp:GridView ID="AttachedFiles" runat="server" BorderStyle="Solid" AutoGenerateColumns ="false"
            Caption="" EnableTheming="True" Font-Names="Arial" 
            Font-Size="Smaller" OnRowDataBound="AttachedFiles_RowDataBound">
            <SelectedRowStyle BackColor="#000066" ForeColor="White" />
            <HeaderStyle BackColor="#9900CC" ForeColor="White" />
            <EditRowStyle BackColor="#9900CC" />
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
            <asp:TemplateField Visible="false">
                <HeaderStyle CssClass="" Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("Request Id").ToString() %>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
          <%--<asp:TemplateField HeaderText="File ID" ControlStyle-Font-Size="X-Small" visible="false">
                <HeaderStyle CssClass="" Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                <asp:Label ID="lblFileId" runat="server" Text='<%# Eval("File Id").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
            
            <asp:TemplateField HeaderText="File Name" ControlStyle-Font-Size="X-Small">
                <ControlStyle Font-Size="X-Small"></ControlStyle>
                <HeaderStyle CssClass=""  Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ItemTemplate>
                    <asp:Label ID="lblFileName" runat="server" Text='<%# Eval("FILE_NAME").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="File Size" ControlStyle-Font-Size="X-Small">
                <HeaderStyle CssClass=""  Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                      <asp:Label ID="lblFileSize" Text='<%# DataBinder.Eval(Container.DataItem, "FILE_SIZE") %>' runat="server" OnDataBinding="lblFileSize_DataBinding" />
					  <asp:Label ID="lblKB" Text="&nbsp;kb" runat="server" />
                    <%--<asp:Label ID="lblFileSize" runat="server" OnDataBinding="lblFileSize_DataBinding" Text='<%# Eval("FILE_SIZE").ToString() %>'</asp:Label>
                    <asp:Label ID="lblKB" Text="&nbsp;kb" runat="server" />--%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Download">
                <HeaderStyle CssClass="" Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                    <a id="_download" href='LeaveRequestView.aspx?type=<%#DataBinder.Eval(Container.DataItem,"Request ID").ToString()%>' runat="server">
                        <asp:Image ID="imgView" runat="server" ImageUrl="Images/View.jpg" Height="16" Width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>     

            <asp:TemplateField HeaderText="Delete">
                <HeaderStyle CssClass="" Font-Size="Small"/>
                <ItemStyle CssClass="" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                    <a id="_delete" href='#' runat="server">
                        <asp:Image ID="imgDelete" runat="server" ImageUrl="Images/Delete.jpg" Height="16" Width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>     

        </Columns>
        </asp:GridView>
        
					<asp:Button runat="server" id="btnDownload" OnClick="btnDownload_Click" 
                        Text="Download Selected" Visible="False" />
				</fieldset>
			</div>
		</form>
	</body>
</html>