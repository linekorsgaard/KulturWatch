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

public partial class Signup : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        if(Page.IsValid)
        {
            if (chkAccept.Checked)
            {
                if (checkIfUserExists(txtEmail.Text))
                {
                    lblError.Text = "En bruger med denne e-mail findes allerede.";
                }
                else
                {
                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        string InsertData = "INSERT INTO KW_Users VALUES (@Name, @Address, @Zip, @City, @Telephone, @Email, @Password, @DateSignedUp, @FK_UserLevelID)";

                        using (SqlCommand cmd = new SqlCommand(InsertData))
                        {

                            cmd.Connection = con;
                            cmd.Parameters.AddWithValue("@Name", txtName.Text);
                            cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                            cmd.Parameters.AddWithValue("@Zip", txtZip.Text);
                            cmd.Parameters.AddWithValue("@City", txtCity.Text);
                            cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text);
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                            cmd.Parameters.AddWithValue("@Password", MD5Hash(txtPassword.Text));
                            cmd.Parameters.AddWithValue("@DateSignedUp", DateTime.Now);
                            cmd.Parameters.AddWithValue("@FK_UserLevelID", 2);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();

                            plSignup.Visible = false;
                            lblSuccess.Visible = true;
                        }
                    }

                }
            } else
            {
                lblError.Text = "Accept af betingelserne for abonnementet er påkrævet.";
            }
        }
    }

    // https://www.junian.net/2014/07/password-encryption-using-md5-hash.html
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

    Boolean checkIfUserExists(string email)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Users WHERE Email = @email", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@email", email);
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