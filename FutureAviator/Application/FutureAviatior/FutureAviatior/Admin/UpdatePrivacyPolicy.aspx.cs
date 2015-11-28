using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;

namespace FutureAviator.Admin
{
    public partial class UpdatePrivacyPolicy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!this.IsPostBack)
                {
                    LoadPrivacyPolicy();
                }
            }
            catch (Exception ex)
            {
               Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
               Logger.WriteErrorLog(ex);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int iRetVal = 0;
                using (DAL_PrivacyPolicy objPriv = new DAL_PrivacyPolicy())
                {
                    int PolicyID;
                    int.TryParse(hfPolicyID.Value.Trim(), out PolicyID);
                    if(PolicyID == 0)
                    {
                        DataAccess.PrivacyPolicy priv = new DataAccess.PrivacyPolicy();
                        priv = Helper.AutoFill<DataAccess.PrivacyPolicy>(priv, DBMethod.Add);

                        iRetVal = objPriv.AddUpdatePrivacyPolicy(DBMethod.Add, priv, txtEnglish.Text.Trim(), txtArabic.Text.Trim(), SessionManager.CurrentUser().UserID);
                        if (iRetVal > 0)
                        {
                            Helper.ShowNotification("Privacy Policy added successfully.", BusinessDTO.UINotificationType.Success);
                            ResetForm();
                        }
                        else
                        {
                            Helper.ShowNotification("Failed to add privacy policy. Please check the logs for more details.", BusinessDTO.UINotificationType.Error);
                        }
                    }
                    else
                    {
                        DataAccess.PrivacyPolicy priv = new DataAccess.PrivacyPolicy();
                        priv = Helper.AutoFill<DataAccess.PrivacyPolicy>(priv, DBMethod.Update);
                        priv.ID = PolicyID;
                        iRetVal = objPriv.AddUpdatePrivacyPolicy(DBMethod.Update, priv, txtEnglish.Text.Trim(), txtArabic.Text.Trim(), SessionManager.CurrentUser().UserID);
                        if (iRetVal > 0)
                        {
                            Helper.ShowNotification("Privacy Policy updated successfully.", BusinessDTO.UINotificationType.Success);
                            ResetForm();
                        }
                        else
                        {
                            Helper.ShowNotification("Failed to update privacy policy. Please check the logs for more details.", BusinessDTO.UINotificationType.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
               Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
               Logger.WriteErrorLog(ex);
            }
        }

        private void LoadPrivacyPolicy()
        {
            using(DAL_PrivacyPolicy objPriv = new DAL_PrivacyPolicy())
            {
                //Get English content//
                List<PrivacyPolicyResult> privacyPoliciesEnglish = objPriv.GetPrivacyPolicy(ApplicationLanguages.en);
                foreach(PrivacyPolicyResult policy in privacyPoliciesEnglish)
                {
                    hfPolicyID.Value = policy.ID.ToString();
                    txtEnglish.Text = policy.PolicyContent;
                }
                //Get Arabic content//
                List<PrivacyPolicyResult> privacyPoliciesArabic = objPriv.GetPrivacyPolicy(ApplicationLanguages.ar);
                foreach (PrivacyPolicyResult policy in privacyPoliciesArabic)
                {
                    txtArabic.Text = policy.PolicyContent;
                }
            }
        }

        private void ResetForm()
        {
            txtEnglish.Text = string.Empty;
            txtArabic.Text = string.Empty;
        }
    }
}