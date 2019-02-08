using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Sidebar : System.Web.UI.UserControl
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    private void Page_Load(object sender, System.EventArgs e)
    {
        getLatestNews();
        getEvents();
    }
    
    private void getLatestNews ()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT TOP 10 * FROM KW_Articles JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID ORDER BY DatePublished desc", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    lvLatestNews.DataSource = dt;
                    lvLatestNews.DataBind();
                }
            }

        }
    }

    private void getEvents()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT TOP 10 * FROM KW_Events WHERE FK_EventStatus = 2 ORDER BY DateStart asc", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    DataColumn dateCol = dt.Columns.Add("Date", typeof(String));
                    string format = "dd.MM";

                    foreach (DataRow row in dt.Rows)
                    {
                        DateTime dateStart = DateTime.Parse(row["DateStart"].ToString());
                        row["Date"] = dateStart.ToString(format);
                    }

                    lvEvents.DataSource = dt;
                    lvEvents.DataBind();
                }
            }

        }
    }
}
