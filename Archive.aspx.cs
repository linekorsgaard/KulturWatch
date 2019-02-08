using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Archive : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Page.Title = "Arkiv -- KulturWatch";

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID ORDER BY DatePublished desc", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {

                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        DataColumn dateCol = dt.Columns.Add("Date", typeof(String));
                        string format = "dd.MM";

                        foreach (DataRow row in dt.Rows)
                        {
                            DateTime date = DateTime.Parse(row["DatePublished"].ToString());
                            row["Date"] = date.ToString(format);
                        }

                        lvArchive.DataSource = dt;
                        lvArchive.DataBind();
                    }
                }

            }
        }
    }
}