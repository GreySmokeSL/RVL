using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtistsWebBilling
{
    public partial class CommissionForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lArtist.Text = String.Format("{0} tracks commission since {1} till {2}",
                    Session["Artist"], Session["PeriodStart"], Session["PeriodEnd"]);
            }
        }        
    }
}