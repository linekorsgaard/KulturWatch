using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;

public partial class AdminCategories : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["db"].ConnectionString);
    string imageFolderPath = "/img/categories/";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Categories ORDER BY Sort ASC", con);
            DataTable dt = new DataTable();

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            con.Close();

            lvCategories.DataSource = dt;
            lvCategories.DataBind();

            if (!Directory.Exists(Server.MapPath(imageFolderPath)))
            {
                Directory.CreateDirectory(Server.MapPath(imageFolderPath));
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void btnNewCategory_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
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

            using (con)
            {
                string InsertData = "INSERT INTO KW_Categories VALUES (@Name, @URL, @Sort, @ImagePath)";

                using (SqlCommand cmd = new SqlCommand(InsertData))
                {

                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Name", txtCategoryName.Text);
                    cmd.Parameters.AddWithValue("@URL", Regex.Replace(txtCategoryName.Text, @"[^A-Za-z0-9_\.~]+", "-").ToLower());
                    cmd.Parameters.AddWithValue("@Sort", 999);
                    cmd.Parameters.AddWithValue("@ImagePath", imgPath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect("AdminCategories.aspx");
                }
            }
        }
    }

    public void editCategory(Object sender, EventArgs e)
    {
        SqlCommand editCategory = new SqlCommand("UPDATE KW_Categories SET CategoryName='" + Request.Form["Name" + (sender as Button).CommandArgument.ToString()] + "' WHERE CategoryID=" + (sender as Button).CommandArgument, con);

        con.Open();
        editCategory.ExecuteNonQuery();
        con.Close();

        Response.Redirect("AdminCategories.aspx");
    }

    public void deleteCategory(Object sender, EventArgs e)
    {
        using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles WHERE FK_CategoryID=" + (sender as Button).CommandArgument))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);

                    foreach (DataRow row in dt.Rows) {
                        SqlCommand deleteCommentsFromArticles = new SqlCommand("DELETE FROM KW_Comments WHERE FK_ArticleID=" + row["ArticleID"], con);

                        con.Open();
                        deleteCommentsFromArticles.ExecuteNonQuery();
                        con.Close();
                    }
                }
            }
        }

        SqlCommand deleteNewsFromCategory = new SqlCommand("DELETE FROM KW_Articles WHERE FK_CategoryID=" + (sender as Button).CommandArgument, con);

        con.Open();
        deleteNewsFromCategory.ExecuteNonQuery();
        con.Close();

        SqlCommand deleteFollowersFromCategory = new SqlCommand("DELETE FROM KW_UserIsFollowing WHERE FK_CategoryID=" + (sender as Button).CommandArgument, con);

        con.Open();
        deleteFollowersFromCategory.ExecuteNonQuery();
        con.Close();

        SqlCommand deleteCategory = new SqlCommand("DELETE FROM KW_Categories WHERE CategoryID=" + (sender as Button).CommandArgument, con);

        con.Open();
        deleteCategory.ExecuteNonQuery();
        con.Close();

        Response.Redirect("AdminCategories.aspx");
    }
}