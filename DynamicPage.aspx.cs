using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class DynamicPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string PageURL = this.Page.RouteData.Values["Page"].ToString();
            string query = "SELECT * FROM KW_Pages WHERE URL = @URL";
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@URL", PageURL);
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            con.Open();
                            sda.Fill(dt);
                            con.Close();

                            if (dt.Rows.Count > 0)
                            {
                                Page.Title = dt.Rows[0]["PageName"].ToString() + " -- KulturWatch";
                                liPage.InnerText = dt.Rows[0]["PageName"].ToString();
                                lblTitle.Text = dt.Rows[0]["PageName"].ToString();
                                lblContent.Text = dt.Rows[0]["BodyText"].ToString();

                                if (dt.Rows[0]["ImagePath"].ToString() != "")
                                {
                                    imgPage.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
                                }
                            }
                            else
                            {
                                Response.Redirect("/404.aspx");
                            }
                        }
                    }
                }
            }

            if (Request.Url.AbsoluteUri.ToString().Split('/').Last() == "om.aspx")
            {
                plAbout.Visible = true;
            }
        }
    }
}