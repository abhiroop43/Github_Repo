using BusinessDTO;
using DataAccess;
using FutureAviator.Utlitity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class JobComponents : System.Web.UI.Page
    {

        #region Add Industry
        #region Events
        protected void btnAddIndustry_Click(object sender, EventArgs e)
        {
            AddUpdateIndustry(DBMethod.Add);

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdateIndustry(DBMethod.Update);
        }
        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            ShowAllControls();
        }
        #endregion
        #region Methods
        private void BindIndustryData(Int32 IndustryID)
        {
            try
            {
                using (DAL_Industry dalIndustry = new DAL_Industry())
                {
                    EditIndustryResult industryResult = dalIndustry.GetIndustryByID(IndustryID);
                    if (industryResult != null)
                    {
                        txtIndusryNameArabic.Text = industryResult.IndustryNameArabic;
                        txtIndusryNameEnglish.Text = industryResult.IndustryNameEnglish;
                        chkbxIsActve.Checked = industryResult.IsActive;

                        hdnIndustryNameTranslationID.Value = industryResult.IndustryNameTranslationID.ToString();
                        hdnIndustryID.Value = IndustryID.ToString();
                    }
                    else
                    {
                        Helper.ShowNotification("Record not found!", UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        private void AddUpdateIndustry(DBMethod method)
        {
            long industryNameTranslationID = 0;
            int industryID = 0;
            if (method == DBMethod.Add)
            {
                industryNameTranslationID = DataAccess.DBHelper.GetUniqueID();

            }
            else
                industryNameTranslationID = Convert.ToInt64(hdnIndustryNameTranslationID.Value);

            using (DataAccess.DAL_Industry dalIndustry = new DataAccess.DAL_Industry())
            {
                int IndustryID = 0;
                DataAccess.Industry industry = new DataAccess.Industry();

                if (method == DBMethod.Add)
                {
                    industry = Helper.AutoFill<DataAccess.Industry>(industry, BusinessDTO.DBMethod.Add);
                }
                else
                {
                    industry = Helper.AutoFill<DataAccess.Industry>(industry, BusinessDTO.DBMethod.Update);
                    industryID = Convert.ToInt32(hdnIndustryID.Value);
                }

                industry.IndustryNameTranslationID = industryNameTranslationID;

                industry.IsActive = chkbxIsActve.Checked;
                if (method == DBMethod.Add)
                {
                    IndustryID = dalIndustry.AddIndustry(industry);
                    if (IndustryID > 0)
                    {
                        DataAccess.DBHelper.AddLanguageContent(industryNameTranslationID, txtIndusryNameEnglish.Text, txtIndusryNameArabic.Text, BusinessDTO.LanguageContentType.IndustryName);
                        ShowAllControls();
                        BindIndustriesGrid();
                        Helper.ShowNotification("Industry Saved successfully.", BusinessDTO.UINotificationType.Success);
                    }

                    else
                        Helper.ShowNotification("Industry Not Saved.", BusinessDTO.UINotificationType.Error);
                }
                else
                {
                    if (dalIndustry.UpdateIustryByID(industryID, industry))
                    {
                        DataAccess.DBHelper.UpdateLanguageContent(industryNameTranslationID, txtIndusryNameEnglish.Text, txtIndusryNameArabic.Text, BusinessDTO.LanguageContentType.IndustryName);
                        ShowAllControls();
                        BindIndustriesGrid();
                        Helper.ShowNotification("Record Update Seccessfully.", BusinessDTO.UINotificationType.Success);
                    }
                    else
                    {
                        Helper.ShowNotification("Update Failed.", BusinessDTO.UINotificationType.Error);
                    }
                }

            }
        }
        #endregion
        #endregion

        #region Add Location
        #region Events
        protected void btnUpdateLocation_Click(object sender, EventArgs e)
        {
            AddUpdateLocation(DBMethod.Update);
        }
        protected void btnAddCountry_Click(object sender, EventArgs e)
        {
            AddUpdateLocation(DBMethod.Add);
        }

        private void AddUpdateLocation(DBMethod method)
        {
            long lngUniqueID = 0;
            int CountryID = 0;
            DataAccess.Country country = new DataAccess.Country();

            if (method == DBMethod.Add)
            {
                lngUniqueID = DataAccess.DBHelper.GetUniqueID();
                country = Helper.AutoFill<DataAccess.Country>(country, BusinessDTO.DBMethod.Add);
            }
            else
            {
                country = Helper.AutoFill<DataAccess.Country>(country, BusinessDTO.DBMethod.Update);
                lngUniqueID = Convert.ToInt64(hdnLocationNameTranslationID.Value);
                CountryID = Convert.ToInt32(ViewState["LocationID"]);
            }

            using (DataAccess.DAL_Country dalCountry = new DataAccess.DAL_Country())
            {

                country.CountryNameTranslationID = lngUniqueID;
                country.IsActive = chkbxLocationIsActive.Checked;
                if (method == DBMethod.Add)
                {
                    CountryID = dalCountry.AddCountry(country);
                    if (CountryID > 0)
                    {
                        DataAccess.DBHelper.AddLanguageContent(lngUniqueID, txtCountryNameEnglish.Text, txtCountryNameArabic.Text, BusinessDTO.LanguageContentType.CountryName);
                        Helper.ClearInputs(this.Controls);
                        ShowAllControls();
                        BindLocationsGrid();
                        Helper.ShowNotification("Location Saved successfully.", UINotificationType.Success);
                    }
                    else
                        Helper.ShowNotification("Location Not Saved.", UINotificationType.Error);
                }
                else
                {
                    if (dalCountry.UpdateCountryByID(CountryID, country))
                    {
                        DataAccess.DBHelper.UpdateLanguageContent(lngUniqueID, txtCountryNameEnglish.Text, txtCountryNameArabic.Text, BusinessDTO.LanguageContentType.CountryName);
                        Helper.ClearInputs(this.Controls);
                        BindLocationsGrid();
                        ShowAllControls();
                        Helper.ShowNotification("Location Update successfully.", UINotificationType.Success);
                    }
                    else
                    {
                        Helper.ShowNotification("Location update failed!", UINotificationType.Error);
                    }
                }
            }
        }
        #endregion

        #region Methods

        private void BindLocationData(int LocationID)
        {
            try
            {
                using (DAL_Country dalLocation = new DAL_Country())
                {
                    EditLocationResult locationResult = dalLocation.GetCountryByIDForEditRecord(LocationID);
                    if (locationResult != null)
                    {
                        txtCountryNameEnglish.Text = locationResult.LocationNameEnglish;
                        txtCountryNameArabic.Text = locationResult.LocationNameArabic;
                        chkbxLocationIsActive.Checked = locationResult.IsActive;
                        hdnLocationNameTranslationID.Value = locationResult.LocationNameTranslationID.ToString();
                    }
                    else
                    {
                        Helper.ShowNotification("Location Not Found", UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        #endregion
        #endregion

        #region All Industries
        #region Events

        protected void gvIndustries_PreRender(object sender, EventArgs e)
        {
           try
            {
                if (gvIndustries.Rows.Count > 0)
                {
                    gvIndustries.UseAccessibleHeader = true;
                    gvIndustries.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvIndustries.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
        }

        protected void gvIndustries_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateIndustry")
            {
                ShowHideControls(AddIndustry);
                IndustrySaveButtonArea.Visible = false;
                IndustryUpdateButtonArea.Visible = true;
                ViewState["IndustryID"] = e.CommandArgument;
                BindIndustryData(Convert.ToInt32(e.CommandArgument));
                lblTitleIndustry.Text = "Update Job Industry";
            }
        }
        #endregion
        #region Methods
        private void BindIndustriesGrid()
        {
            try
            {
                using (DAL_Industry dalIndustry = new DAL_Industry())
                {
                    List<IndustryResult> resultList = dalIndustry.GetAllIndustires();
                    if (resultList != null && resultList.Count > 0)
                    {
                        gvIndustries.DataSource = resultList;
                        gvIndustries.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        #endregion
        #endregion

        #region All Locations
        #region Events

        protected void gvAllLocations_PreRender(object sender, EventArgs e)
        {
          

            try
            {
                if (gvAllLocations.Rows.Count > 0)
                {
                    gvAllLocations.UseAccessibleHeader = true;
                    gvAllLocations.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvAllLocations.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
        }

        protected void gvAllLocations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateLocation")
            {
                ViewState["LocationID"] = e.CommandArgument;
                BindLocationData(Convert.ToInt32(e.CommandArgument));
                LocationUpdateButtonArea.Visible = true;
                LocationSaveButtonArea.Visible = false;
                ShowHideControls(AddLocation);
                lblTitleLocation.Text = "Update Job Location";
            }
        }
        #endregion
        #region Methods
        private void BindLocationsGrid()
        {
            try
            {
                using (DAL_Country dalLocation = new DAL_Country())
                {
                    List<LocationResult> resultList = dalLocation.GetAllCountries();
                    if (resultList != null && resultList.Count > 0)
                    {
                        gvAllLocations.DataSource = resultList;
                        gvAllLocations.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        #endregion
        #endregion

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindIndustriesGrid();
                BindLocationsGrid();
            }
        }
        #endregion

        #region Methods
        public void ShowHideControls(System.Web.UI.HtmlControls.HtmlGenericControl showControlID)
        {
            AddIndustry.Visible = false;
            AddLocation.Visible = false;
            AllIndustries.Visible = false;
            AllLocation.Visible = false;
            if (showControlID != null)
                showControlID.Visible = true;
        }
        private void ShowAllControls()
        {
            AddIndustry.Visible = true;
            AddLocation.Visible = true;
            AllIndustries.Visible = true;
            AllLocation.Visible = true;

            IndustrySaveButtonArea.Visible = true;
            IndustryUpdateButtonArea.Visible = false;

            LocationSaveButtonArea.Visible = true;
            LocationUpdateButtonArea.Visible = false;

            lblTitleLocation.Text = "Add Job Location";
            lblTitleIndustry.Text = "Add Job Industry";

            Helper.ClearInputs(Page.Controls);
        }
        #endregion



    }
}
