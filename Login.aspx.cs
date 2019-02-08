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
using System.Collections;
using System.Text;
using System.Security.Cryptography;

public partial class Login : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Page.Title = "Log ind -- KulturWatch";
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT UserID, Name, Password, FK_UserLevelID FROM KW_Users WHERE Email = '" + txtEmail.Text + "'";
                cmd.Connection = con;

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["Password"].ToString() == MD5Hash(txtPassword.Text))
                        {
                            Session["UserID"]   = dt.Rows[0]["UserID"].ToString();
                            Session["UserLvl"]  = dt.Rows[0]["FK_UserLevelID"].ToString();
                            Session["Name"]     = dt.Rows[0]["Name"].ToString();

                            Response.Redirect("Feed.aspx");
                        }
                        else
                        {
                            lblError.Text = "Desværre! Forkert password.";
                        }
                    }
                    else
                    {
                        lblError.Text = "Brugeren eksisterer ikke.";
                    }
                }
            }
        }
    }

    // From https://www.junian.net/2014/07/password-encryption-using-md5-hash.html
    public static string MD5Hash(string text)
    {
        MD5 md5 = new MD5CryptoServiceProvider();

        md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

        byte[] result = md5.Hash;

        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < result.Length; i++)
        {
            strBuilder.Append(result[i].ToString("x2"));
        }
        return strBuilder.ToString();
    }
}