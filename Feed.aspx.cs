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

public partial class Feed : System.Web.UI.Page
{
    private static int i;

    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            btnLoadMore_Click(btnLoadMore, EventArgs.Empty);
        } else
        {
            Response.Redirect("/Login.aspx");
        }

        if (!IsPostBack)
        {
            Page.Title = "Mit feed -- KulturWatch";
        }
    }

    public DataTable getArticles (DataTable dt, int limit)
    {
        DataTable dtArticles = new DataTable();

        foreach (DataRow row in dt.Rows)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmdArticles = new SqlCommand("SELECT TOP " + limit + " * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID LEFT JOIN KW_Users ON KW_Articles.FK_UserID = KW_Users.UserID WHERE FK_CategoryID = " + row["FK_CategoryID"] + " ORDER BY DatePublished DESC", con))
                {
                    using (SqlDataAdapter sdaArticles = new SqlDataAdapter(cmdArticles))
                    {
                        DataTable dtNewArticles = new DataTable();
                        sdaArticles.Fill(dtNewArticles);

                        if (dtNewArticles.Rows.Count > 0)
                        {
                            dtArticles.Merge(dtNewArticles);
                            btnLoadMore.Visible = true;
                        }
                    }
                }
            }
        }

        if (dtArticles.Rows.Count > 0)
        {
            dtArticles.DefaultView.Sort = "[DatePublished] DESC";
        }

        return dtArticles.DefaultView.ToTable();
    }

    protected void btnLoadMore_Click(object sender, EventArgs e)
    {
        i++;

        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_UserIsFollowing WHERE FK_UserID = " + Int32.Parse(Session["UserID"].ToString()), con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    lvFeed.DataSource = getArticles(dt, i);
                    lvFeed.DataBind();
                }
            }
        }
    }
}