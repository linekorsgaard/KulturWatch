using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class DynamicCategory : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        string categoryURL = this.Page.RouteData.Values["CategoryName"].ToString();

        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Categories WHERE CategoryURL = @URL"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@URL", categoryURL);
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            Page.Title = dt.Rows[0]["CategoryName"].ToString() + " på KulturWatch";
                            liCategory.InnerText = dt.Rows[0]["CategoryName"].ToString();
                            lblName.Text = dt.Rows[0]["CategoryName"].ToString();

                            if (Session["UserID"] != null)
                            {
                                Button btn = new Button();
                                btn.ID = "btnFollow";
                                btn.CssClass = "btn btn-primary pull-right u-margin-top-2";

                                if (checkIfFollowing(Int32.Parse(dt.Rows[0]["CategoryID"].ToString())))
                                {
                                    btn.Visible = false;

                                    Button btnUnfollow = new Button();
                                    btnUnfollow.Text = "Stop med at følge";
                                    btnUnfollow.ID = "btnUnfollow";
                                    btnUnfollow.CssClass = "btn btn-default pull-right u-margin-top-2";
                                    btnUnfollow.CommandArgument = dt.Rows[0]["CategoryID"].ToString();
                                    btnUnfollow.Click += new EventHandler(btnUnfollow_Click);

                                    btnPlaceholder.Controls.Add(btnUnfollow);
                                }
                                else
                                {
                                    btn.Text = "Følg kategori";
                                    btn.CommandArgument = dt.Rows[0]["CategoryID"].ToString();
                                    btn.Click += new EventHandler(btnFollow_Click);
                                }

                                btnPlaceholder.Controls.Add(btn);
                            }

                            DataTable dtNews1 = getNewsByCategory(Int32.Parse(dt.Rows[0]["CategoryID"].ToString()), 0, 4);

                            foreach (DataRow rowNews1 in dtNews1.Rows)
                            {
                                if (Int32.Parse(rowNews1["Locked"].ToString()) == 1)
                                {
                                    rowNews1["Headline"] = rowNews1["Headline"].ToString() + " <i class='fa fa-key'></i>";
                                }
                            }

                            lvNews1.DataSource = dtNews1;
                            lvNews1.DataBind();

                            DataTable dtNews2 = getNewsByCategory(Int32.Parse(dt.Rows[0]["CategoryID"].ToString()), 4, 9);

                            foreach (DataRow rowNews2 in dtNews2.Rows)
                            {
                                if (Int32.Parse(rowNews2["Locked"].ToString()) == 1)
                                {
                                    rowNews2["Headline"] = rowNews2["Headline"].ToString() + " <i class='fa fa-key'></i>";
                                }
                            }

                            lvNews2.DataSource = dtNews2;
                            lvNews2.DataBind();

                            if (dt.Rows[0]["CategoryImagePath"].ToString() != "")
                            {
                                HtmlGenericControl body = (HtmlGenericControl)Master.FindControl("bodyTag");
                                body.Style["background-image"]  = dt.Rows[0]["CategoryImagePath"].ToString();
                                body.Style["background-repeat"] = "no-repeat";
                                body.Style["background-size"]   = "cover";
                                body.Style["background-attachment"] = "fixed";
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

    }

    protected void btnFollow_Click(object sender, EventArgs e)
    {
        int categoryID = Int32.Parse(((Button)sender).CommandArgument);
        int userID = Int32.Parse(Session["UserID"].ToString());

        using (SqlConnection con = new SqlConnection(constr))
        {
            string InsertData = "INSERT INTO KW_UserIsFollowing VALUES (@UserID, @CategoryID)";

            using (SqlCommand cmd = new SqlCommand(InsertData))
            {
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@UserID", userID);
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }

    protected Boolean checkIfFollowing(int categoryID)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_UserIsFollowing WHERE FK_UserID = " + Int32.Parse(Session["UserID"].ToString()) + " AND FK_CategoryID =" + categoryID))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;

                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }

                    }
                }
            }
        }
    }

    protected void btnUnfollow_Click(object sender, EventArgs e)
    {
        int categoryID = Int32.Parse(((Button)sender).CommandArgument);
        int userID = Int32.Parse(Session["UserID"].ToString());

        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand deleteNews = new SqlCommand("DELETE FROM KW_UserIsFollowing WHERE FK_UserID=" + userID + " AND FK_CategoryID = " + categoryID, con);

            con.Open();
            deleteNews.ExecuteNonQuery();
            con.Close();

            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }

    DataTable getNewsByCategory (int categoryID, int offset, int limit)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID WHERE FK_CategoryID = " + categoryID + " ORDER BY DatePublished desc OFFSET " + offset + " ROWS FETCH NEXT " + limit + " ROWS ONLY", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    return dt;
                }
            }
        }
    }
}