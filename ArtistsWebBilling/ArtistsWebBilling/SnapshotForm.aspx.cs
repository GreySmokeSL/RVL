using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtistsWebBilling
{
    public partial class SnapshotForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lArtist.Text = String.Format("{0} tracks hourly snapshot since {1} till {2}",
                    Session["Artist"], Session["PeriodStart"], Session["PeriodEnd"]);
            }
        }        
    }
}