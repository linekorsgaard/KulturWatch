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

public partial class AdminUsers : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["db"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Users JOIN KW_UserLevels ON KW_Users.FK_UserLevelID = KW_UserLevels.UserLevelID ORDER BY DateSignedUp ASC", con);
            DataTable dt = new DataTable();

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            con.Close();

            lvUsers.DataSource = dt;
            lvUsers.DataBind();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

    public void editUser(Object sender, EventArgs e)
    {
        SqlCommand deleteUser = new SqlCommand("UPDATE KW_Users SET Name='" + Request.Form["Name" + (sender as Button).CommandArgument.ToString()] + "', Address ='" + Request.Form["Address" + (sender as Button).CommandArgument] + "', Zip = '" + Request.Form["Zip" + (sender as Button).CommandArgument] + "', City ='" + Request.Form["City" + (sender as Button).CommandArgument] + "', Telephone = '" + Request.Form["Telephone" + (sender as Button).CommandArgument.ToString()] + "', FK_UserLevelID = '" + Request.Form["FK_UserLevelID" + (sender as Button).CommandArgument.ToString()] + "', Email = '" + Request.Form["Email" + (sender as Button).CommandArgument.ToString()] + "' WHERE UserID=" + (sender as Button).CommandArgument, con);

        con.Open();
        deleteUser.ExecuteNonQuery();
        con.Close();

        Response.Redirect("AdminUsers.aspx");
    }

    public void deleteUser(Object sender, EventArgs e)
    {
        SqlCommand deleteUser = new SqlCommand("DELETE FROM KW_Users WHERE UserID=" + (sender as Button).CommandArgument, con);

        con.Open();
        deleteUser.ExecuteNonQuery();
        con.Close();

        Response.Redirect("AdminUsers.aspx");

    }


}