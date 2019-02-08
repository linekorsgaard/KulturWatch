using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Search : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Page.Title = "Søg -- KulturWatch";
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID WHERE Headline LIKE '" + txtSearch.Text + "' OR Lede LIKE '" + txtSearch.Text + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;

                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);

                        lvResults.Visible = true;
                        lvResults.DataSource = dt;
                        lvResults.DataBind();
                    }
                }
            }
        }
    }
}