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
using System.Text.RegularExpressions;

public partial class AdminPages : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
    string imageFolderPath = "/img/pages/";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Pages JOIN KW_Users ON KW_Pages.FK_UserID = KW_Users.UserID ORDER BY Sort asc", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            lvPages.DataSource = dt;
                            lvPages.DataBind();
                        }
                    }

                    if (Request.QueryString["edit"] != null)
                    {
                        createPage.Visible = false;
                        editPage.Visible = true;

                        using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Pages WHERE PageID = " + Request.QueryString["edit"], con))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                sda.Fill(dt);

                                if (dt.Rows.Count > 0)
                                {
                                    txtName.Text    = dt.Rows[0]["PageName"].ToString();
                                    txtContent.Text = dt.Rows[0]["BodyText"].ToString();
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

        if (!Directory.Exists(Server.MapPath(imageFolderPath)))
        {
            Directory.CreateDirectory(Server.MapPath(imageFolderPath));
        }
    }

    public void deletePage(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand deleteNews = new SqlCommand("DELETE FROM KW_Pages WHERE PageID=" + (sender as Button).CommandArgument, con);

            con.Open();
            deleteNews.ExecuteNonQuery();
            con.Close();

            Response.Redirect("AdminPages.aspx");
        }
    }

    protected void btnSavePage_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string UpdateData = "UPDATE KW_Pages SET PageName = @PageName, BodyText = @BodyText WHERE PageID = " + Request.QueryString["edit"];

                using (SqlCommand cmd = new SqlCommand(UpdateData))
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@PageName", txtName.Text);
                    cmd.Parameters.AddWithValue("@BodyText", txtContent.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }
    }

    protected void btnCreatePage_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string URL = Regex.Replace(txtCreateName.Text, @"[^A-Za-z0-9_\.~]+", "-").ToLower();

            if (checkIfPageExists(URL))
            {
                lblError.Text = "Vælg venligst en anden overskrift. Denne eksiterer allerede.";
            }
            else
            {
                string imgPath;

                if (fuImage.HasFile)
                {
                    string imageFileName = Path.GetFileName(fuImage.PostedFile.FileName);
                    fuImage.PostedFile.SaveAs(Server.MapPath(imageFolderPath) + imageFileName);
                    imgPath = imageFolderPath + imageFileName;
                }
                else
                {
                    imgPath = "";
                }

                using (SqlConnection con = new SqlConnection(constr))
                {
                    string InsertData = "INSERT INTO KW_Pages VALUES (@Name, @URL, @ImagePath, @Content, @DateCreated, @Sort, @FK_UserID)";

                    using (SqlCommand cmd = new SqlCommand(InsertData))
                    {

                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Name", txtCreateName.Text);
                        cmd.Parameters.AddWithValue("@URL", Regex.Replace(txtCreateName.Text, @"[^A-Za-z0-9_\.~]+", "-").ToLower());
                        cmd.Parameters.AddWithValue("@ImagePath", imgPath);
                        cmd.Parameters.AddWithValue("@Content", txtCreateContent.Text);
                        cmd.Parameters.AddWithValue("@DateCreated", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Sort", 999);
                        cmd.Parameters.AddWithValue("@FK_UserID", Int32.Parse(Session["UserID"].ToString()));

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        Response.Redirect("AdminPages.aspx");
                    }
                }
            }
        }
    }

    Boolean checkIfPageExists(string URL)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Pages WHERE URL = @URL", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@URL", URL);
                    sda.SelectCommand = cmd;

                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
}