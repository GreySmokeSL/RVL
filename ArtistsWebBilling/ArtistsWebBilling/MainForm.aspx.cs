using ArtistsWebBilling.Helper;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtistsWebBilling
{
    public partial class MainForm : System.Web.UI.Page
    {
        private const string TextDateFormat = "yyyy-MM-dd";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (tbFirstDate.Text.IsNone())
                    tbFirstDate.Text = DateTime.Today.AddDays(-30).ToString(TextDateFormat);
                if (tbLastDate.Text.IsNone())
                    tbLastDate.Text = DateTime.Today.AddDays(-1).ToString(TextDateFormat);
                if (tbArtistCount.Text.IsNone())
                    tbArtistCount.Text = "100";
            }
        }

        protected void bShowComission_Click(object sender, EventArgs e)
        {
            ShowData("CommissionForm.aspx");            
        }

        protected void bShowSnapshot_Click(object sender, EventArgs e)
        {
            ShowData("SnapshotForm.aspx");
        }

        protected void ShowData(string redirectUrl)
        {
            try
            {
                if (ValidatePeriod(tbFirstDate.Text, tbLastDate.Text))
                {
                    Session["ArtistID"] = ddlArtist.SelectedValue;
                    Session["PeriodStart"] = tbFirstDate.Text;
                    Session["PeriodEnd"] = tbLastDate.Text;
                    Session["Artist"] = ddlArtist.SelectedItem.Text;
                    Response.Redirect(redirectUrl);
                }
                else Response.Write("Invalid period!");
            }
            catch (Exception ex)
            {
                AddLog(ex.ToString());
            }
        }

        private bool ValidatePeriod(string periodStart, string periodEnd)
        {
            DateTime start, end;
            return
                DateTime.TryParseExact(periodStart, TextDateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out start) &&
                DateTime.TryParseExact(periodEnd, TextDateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out end) &&
                end >= start;
        }

        protected void bReloadData_Click(object sender, EventArgs e)
        {
            try
            {
                var artistCount = Convert.ToInt32(tbArtistCount.Text);
                if (artistCount > 0)
                {
                    var sw = new Stopwatch();
                    sw.Start();
                    var result = FakeDataGenerator.GenerateData(artistCount);                    
                    ddlArtist.DataBind();
                    sw.Stop();
                    var message = String.Format("Data reloaded successfully, time: {0:f2} sec.", sw.Elapsed.TotalSeconds);
                    AddLog(message);
                    AddLog(result);
                }
                else
                    AddLog("Invalid artist count: " + tbArtistCount.Text);
            }
            catch (Exception ex)
            {
                AddLog(ex.ToString());
            }
        }

        private void AddLog(string message)
        {
            lbStatus.Items.Insert(0, message);//Response.Write(ex);
        }
    }
}