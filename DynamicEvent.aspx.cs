using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class DynamicEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string EventURL = this.Page.RouteData.Values["EventName"].ToString();
            string query = "SELECT * FROM KW_Events WHERE URL = @URL";
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@URL", EventURL);
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            con.Open();
                            sda.Fill(dt);
                            con.Close();

                            if (dt.Rows.Count > 0)
                            {
                                Page.Title = dt.Rows[0]["EventName"].ToString() + " på KulturWatch";
                                liEvent.InnerText = dt.Rows[0]["EventName"].ToString();
                                lblTitle.Text = dt.Rows[0]["EventName"].ToString();
                                lblContent.Text = dt.Rows[0]["Description"].ToString();

                                DateTime dateStart  = DateTime.Parse(dt.Rows[0]["DateStart"].ToString());
                                DateTime dateEnd    = DateTime.Parse(dt.Rows[0]["DateEnd"].ToString());
                                lblDateStart.Text   = dateStart.ToString("dd.MM.yyyy");
                                lblDateEnd.Text     = dateEnd.ToString("dd.MM.yyyy");

                                lblPrice.Text = dt.Rows[0]["Price"].ToString();
                                lblReducedPrice.Text = dt.Rows[0]["ReducedPrice"].ToString();
                            }
                            else
                            {
                                Response.Redirect("/404.aspx");
                            }
                        }
                    }
                }
            }
        }

    }
}