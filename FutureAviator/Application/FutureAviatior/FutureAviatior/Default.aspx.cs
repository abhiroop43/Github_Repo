using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FutureAviator.Utlitity;
using System.Data;
using ExceptionLogger;
using DataAccess;
using BusinessDTO;
using System.Web.Services;

namespace FutureAviator
{
    public partial class Default : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (Request.Cookies["language"] != null)
            {
                string languageCode = Request.Cookies["language"].Value.Trim();

                UICulture = languageCode == "ar" ? "ar-ae" : "en-us";
                Culture = languageCode == "ar" ? "ar-ae" : "en-us";
                if (SessionManager.CurrentUser() != null)
                    SessionManager.CurrentUser().LanguageCode = languageCode == "ar" ? ApplicationLanguages.ar : ApplicationLanguages.en;

            }
            else
            {
                UICulture = "en-us";
                Culture = "en-us";
                if (SessionManager.CurrentUser() != null)
                    SessionManager.CurrentUser().LanguageCode = ApplicationLanguages.en;
                HttpCookie LanguageCookies = new HttpCookie("language");
                LanguageCookies.Value = "en";
                LanguageCookies.Expires = DateTime.Now.AddYears(10);
                Response.Cookies.Add(LanguageCookies);
            }
            base.InitializeCulture();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write("SESSION<br>");
            //Response.Write(((int)SessionManager.CurrentUser().LanguageCode));
            //Response.Write("<br>COOKIES<br>");
            //Response.Write(Request.Cookies["language"].Value);
            // Response.End();
            //if (!IsPostBack)
            //{
            try
            {
                if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en)
                {
                    addStyle.Attributes.Add("style", "border-left: 5px dotted #e3e3e3");
                    AddStyle2.Attributes.Add("style", "border-left: 5px dotted #e3e3e3");
                    lblLoginUserName.CssClass = "padding4 MainTop";
                    hypLogin.Attributes.Add("class", "padding4 MainTop");
                }
                else
                {
                    addStyle.Attributes.Add("style", "border-right: 5px dotted #e3e3e3");
                    AddStyle2.Attributes.Add("style", "border-right: 5px dotted #e3e3e3");
                }
                if (!IsPostBack)
                {
                    SetCarrers();
                    ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                    //scriptManager.RegisterPostBackControl(ContactUs.FindControl("btnSubmit"));
                }

                if (SessionManager.CurrentUser() != null && SessionManager.CurrentUser().UserID > 0)
                {
                    lblLoginUserName.Visible = true;
                    lblLoginUserName.Text = "Welcome, " + SessionManager.CurrentUser().DisplayName;
                    hypLogin.HRef = "~/Logout.aspx";
                    hypLogin.Attributes.Remove("onclick");
                    hypLogin.InnerText = "Logout";
                }
                else
                {
                    lblLoginUserName.Visible = false;
                    lblLoginUserName.Text = string.Empty;
                    hypLogin.InnerText = "Login";
                }
                if (!this.IsPostBack)
                {
                    LoadCMSContent();
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
            //}
        }

        private void SetCarrers()
        {
            try
            {
                DisplayCareers.ContentBoxType = BusinessDTO.ImageContentBoxType.Carrers;
                DisplayNationalCarrers.ContentBoxType = BusinessDTO.ImageContentBoxType.NationalCarrers;
                DisplayUAEStudy.ContentBoxType = BusinessDTO.ImageContentBoxType.UAEStudy;
                DisplayInternationalStudy.ContentBoxType = BusinessDTO.ImageContentBoxType.InternationalStudy;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        [WebMethod]
        public static string SendContactRequest(string name, string email, string msg)
        {
            try
            {
                DAL_ContactCustomer objContact = new DAL_ContactCustomer();
                ContactCustomer custDetails = new ContactCustomer();
                custDetails.CustName = name.Trim();
                custDetails.CustEmail = email.Trim();
                //custDetails.CustProject = txtProject.Text.Trim();
                custDetails.CustProject = "";
                custDetails.CustMessage = msg.Trim();
                //Helper.AutoFill<ContactCustomer>(custDetails, BusinessDTO.DBMethod.Add);
                custDetails.AddedBy = SessionManager.CurrentUser().UserID.ToString();
                custDetails.AddedOn = DateTime.Today;

                if (objContact.AddContactRequest(custDetails) > 0)
                {
                    //send email//
                    Emailer objEmail = new Emailer();
                    //objEmail.SendEmail(txtEmail.Text.Trim(), txtMessage.Text.Trim(), txtProject.Text.Trim());
                    objEmail.SendEmail(System.Configuration.ConfigurationManager.AppSettings["NoReply"].ToString(), name.Trim(), email.Trim(), msg.Trim(), "");
                    return "success";
                }
                else
                {
                    Logger.WriteMessage("Error while submitting contact request.");
                    return "failure";
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return "failure";
            }
        }

        private void LoadCMSContent()
        {
            using (DAL_CMS objCMS = new DAL_CMS())
            {
                //if (SessionManager.CurrentUser() != null)
                //{
                List<CMSSectionResult> sections = objCMS.GetCMSContent(SessionManager.CurrentUser().LanguageCode);

                foreach (CMSSectionResult cms in sections)
                {
                    if (cms.SectionTypeID == (int)CMSSectionTypes.ABOUTUS)
                    {
                        cmsAboutUsHeader.InnerText += cms.SectionName;
                        cmsAboutUs.InnerText += Helper.ConvertHTMLToText(cms.SectionText);
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTERNATIONAL_AVIATION_OVERVIEW)
                    {
                        cmsIntlAviationOverviewHeader.InnerHtml += cms.SectionName;
                        cmsIntlAviationOverView.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.WHY_HAVE_A_CAREER_IN_AVIATION_HEADER)
                    {
                        cmsWhyCareerHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.WHY_HAVE_A_CAREER_IN_AVIATION_1)
                    {
                        cmsWhyHaveCareerInAviation1.InnerHtml = "<h2>" + cms.SectionName + "</h2>";
                        cmsWhyHaveCareerInAviation1.InnerHtml += "<p>" + cms.SectionText + "</p>";
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.WHY_HAVE_A_CAREER_IN_AVIATION_2)
                    {
                        cmsWhyHaveCareerInAviation2.InnerHtml = "<h2>" + cms.SectionName + "</h2>";
                        cmsWhyHaveCareerInAviation2.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTRODUCTION_TO_GCAA)
                    {
                        cmsIntroToGCAAHeader.InnerHtml += cms.SectionName;
                        cmsIntroTOGCAA.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.UAE_OVERVIEW_AND_EMIRATIZATION)
                    {
                        cmsUAEOverviewHeader.InnerHtml += cms.SectionName;
                        cmsUAEOverview.InnerHtml += cms.SectionText;
                        continue;
                    }

                    if (cms.SectionTypeID == (int)CMSSectionTypes.CAREER_HEADER)
                    {
                        job.InnerHtml = cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.NATIONAL_CAREER_CONTENT)
                    {
                        cmsNationalCareerHeader.InnerHtml += cms.SectionName;
                        cmsNationalCareers.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.EDUCATION_HEADER)
                    {
                        cmsEducationMainHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.UAE_STUDY)
                    {
                        cmsUAEStudyHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTERNATIONAL_STUDY)
                    {
                        cmsIntlStudyHeader.InnerHtml += cms.SectionName;
                        continue;
                    }

                    if (cms.SectionTypeID == (int)CMSSectionTypes.MEDIA_HEADER)
                    {
                        cmsMediaMainHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.PRESS_RELEASES)
                    {
                        cmsPressRlsHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.EVENTS)
                    {
                        cmsEventsHeader.InnerHtml += cms.SectionName;
                        continue;
                    }

                    //TIPS & ADVICE START//
                    if (cms.SectionTypeID == (int)CMSSectionTypes.TIPS_ADVICE_HEADER)
                    {
                        TipsAdviceMainHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTERVIEW_TECHNIQUES_1)
                    {
                        cmsInterviewTech1Header.InnerHtml += cms.SectionName;
                        cmsInterviewTech1Content.InnerHtml += "<div>" + cms.SectionText + "</div>";
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.PERSONAL_DETAILS)
                    {
                        cmsPersonalDetailsHeader.InnerHtml += cms.SectionName;
                        cmsPersonalDetailsContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.EDUCATION_AND_QUALIFICATIONS)
                    {
                        cmsEducationQualificationHeader.InnerHtml += cms.SectionName;
                        cmsEducationQualificationContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.WORK_EXPERIENCE)
                    {
                        cmsWorkExHeader.InnerHtml += cms.SectionName;
                        cmsWorkExContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTERESTS_AND_ACHIEVEMENTS)
                    {
                        cmsInterestAchievementsHeader.InnerHtml += cms.SectionName;
                        cmsInterestAchievementsContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.SKILLS)
                    {
                        cmsSkillsHeader.InnerHtml += cms.SectionName;
                        cmsSkillsContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.REFERENCES)
                    {
                        cmsReferencesHeader.InnerHtml += cms.SectionName;
                        cmsReferencesContent.InnerHtml += cms.SectionText;
                        continue;
                    }
                    if (cms.SectionTypeID == (int)CMSSectionTypes.INTERVIEW_TECHNIQUES_2)
                    {
                        cmsInterviewTech2Header.InnerHtml += cms.SectionName;
                        cmsInterviewTech2Content.InnerHtml += cms.SectionText;
                        continue;
                    }
                    //TIPS & ADVICE END//

                    if (cms.SectionTypeID == (int)CMSSectionTypes.LOCATION_MAP)
                    {
                        cmsLocationMapMainHeader.InnerHtml += cms.SectionName;
                        continue;
                    }
                }
                //}
            }
        }


    }
}