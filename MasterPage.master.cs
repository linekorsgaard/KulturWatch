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

public partial class MasterPage : System.Web.UI.MasterPage
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserLvl"] != null)
            {
                lblUserName.Text = Session["Name"].ToString();

                phNavStandard.Visible = false;

                if (Int32.Parse(Session["UserLvl"].ToString()) == 1)
                {
                    adminNav.Visible = true;
                    phNavBusiness.Visible = true;

                }
                else if (Int32.Parse(Session["UserLvl"].ToString()) == 2)
                {
                    phNavBusiness.Visible = true;
                }
                else
                {
                    phNavLoggedIn.Visible = true;
                }
            }
        }

        Utility_Navigation();
        Navigation();
    }

    protected void Utility_Navigation()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT PageName, URL FROM KW_Pages ORDER BY Sort asc", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    lvNavUtility.DataSource = dt;
                    lvNavUtility.DataBind();
                }
            }
        }
    }

    protected void Navigation()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT CategoryName, CategoryURL FROM KW_Categories ORDER BY Sort asc", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    lvNav.DataSource = dt;
                    lvNav.DataBind();

                    lvSections.DataSource = dt;
                    lvSections.DataBind();
                }
            }
        }
    }
}