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

public partial class AdminNews : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Users ON KW_Articles.FK_UserID = KW_Users.UserID LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID ORDER BY ArticleID desc", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            lvNews.DataSource = dt;
                            lvNews.DataBind();
                        }
                    }

                    if (Request.QueryString["edit"] != null)
                    {
                        editNews.Visible = true;

                        using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Users ON KW_Articles.FK_UserID = KW_Users.UserID LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID WHERE ArticleID = " + Request.QueryString["edit"], con))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                sda.Fill(dt);

                                if (dt.Rows.Count > 0)
                                {
                                    txtHeadline.Text = dt.Rows[0]["Headline"].ToString();
                                    txtLede.Text = dt.Rows[0]["Lede"].ToString();
                                    txtBodyText.Text = dt.Rows[0]["BodyText"].ToString();

                                    if (Int32.Parse(dt.Rows[0]["Locked"].ToString()) == 1)
                                    {
                                        chkLocked.Checked = true;
                                    }

                                    populateCategoriesDropDown();

                                    ddlCategory.SelectedValue = dt.Rows[0]["FK_CategoryID"].ToString();
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }

    public void deleteNews(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand deleteComments   = new SqlCommand("DELETE FROM KW_Comments WHERE FK_ArticleID = " + (sender as Button).CommandArgument, con);
            SqlCommand deleteNews       = new SqlCommand("DELETE FROM KW_Articles WHERE ArticleID = " + (sender as Button).CommandArgument, con);

            con.Open();
            deleteComments.ExecuteNonQuery();
            deleteNews.ExecuteNonQuery();
            con.Close();

            Response.Redirect("AdminNews.aspx");
        }
    }

    protected void btnSaveNews_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string UpdateData = "UPDATE KW_Articles SET Headline = @Headline, Lede = @Lede, BodyText = @BodyText, Locked = @Locked, FK_CategoryID = @FK_CategoryID WHERE ArticleID = " + Request.QueryString["edit"];

                using (SqlCommand cmd = new SqlCommand(UpdateData))
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Headline", txtHeadline.Text);
                    cmd.Parameters.AddWithValue("@Lede", txtLede.Text);
                    cmd.Parameters.AddWithValue("@BodyText", txtBodyText.Text);
                    cmd.Parameters.AddWithValue("@Locked", chkLocked.Checked ? 1 : 0);
                    cmd.Parameters.AddWithValue("@FK_CategoryID", ddlCategory.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }
    }

    protected void populateCategoriesDropDown ()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT CategoryID, CategoryName FROM KW_Categories", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    ddlCategory.DataSource = dt;
                    ddlCategory.DataTextField = "CategoryName";
                    ddlCategory.DataValueField = "CategoryID";
                    ddlCategory.DataBind();
                }
            }
        }
    }
}