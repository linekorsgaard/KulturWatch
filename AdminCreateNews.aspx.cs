using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

public partial class AdminCreateNews : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
    string imageFolderPath = "/img/news/";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
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
            else
            {
                Response.Redirect("Login.aspx");
            }

            if (!Directory.Exists(Server.MapPath(imageFolderPath)))
            {
                Directory.CreateDirectory(Server.MapPath(imageFolderPath));
            }
        }
    }

    protected void btnCreateNews_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string URL = Regex.Replace(txtHeadline.Text, @"[^A-Za-z0-9_\.~]+", "-").ToLower();

            if (checkIfArticleExists(URL))
            {
                lblError.Text = "Vælg venligst en anden overskrift. Denne eksiterer allerede.";
            } else
            {
                string imageFileName = Path.GetFileName(fuImage.PostedFile.FileName);
                fuImage.PostedFile.SaveAs(Server.MapPath(imageFolderPath) + imageFileName);

                using (SqlConnection con = new SqlConnection(constr))
                {
                    string InsertData = "INSERT INTO KW_Articles VALUES (@Headline, @Lede, @BodyText, @DatePublished, @ImagePath, @URL, @Locked, @FK_UserID, @FK_CategoryID)";

                    using (SqlCommand cmd = new SqlCommand(InsertData))
                    {
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Headline", txtHeadline.Text);
                        cmd.Parameters.AddWithValue("@Lede", txtLede.Text);
                        cmd.Parameters.AddWithValue("@BodyText", txtBodyText.Text);
                        cmd.Parameters.AddWithValue("@DatePublished", DateTime.Now);
                        cmd.Parameters.AddWithValue("@ImagePath", imageFolderPath + imageFileName);
                        cmd.Parameters.AddWithValue("@URL", URL);
                        cmd.Parameters.AddWithValue("@Locked", chkLocked.Checked ? 1 : 0);
                        cmd.Parameters.AddWithValue("@FK_UserID", Int32.Parse(Session["UserID"].ToString()));
                        cmd.Parameters.AddWithValue("@FK_CategoryID", ddlCategory.SelectedValue);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        Response.Redirect("/AdminNews.aspx");
                    }
                }
            }
        }
    }

    Boolean checkIfArticleExists(string URL)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles WHERE URL = @URL", con))
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