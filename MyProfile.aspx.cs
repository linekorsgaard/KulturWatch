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

public partial class MyProfile : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Page.Title = "Mine oplysninger -- KulturWatch";

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Users WHERE UserID = " + Int32.Parse(Session["UserID"].ToString()), con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            txtName.Text        = dt.Rows[0]["Name"].ToString();
                            txtAddress.Text     = dt.Rows[0]["Address"].ToString();
                            txtZip.Text         = dt.Rows[0]["Zip"].ToString();
                            txtCity.Text        = dt.Rows[0]["City"].ToString();
                            txtTelephone.Text   = dt.Rows[0]["Telephone"].ToString();
                            txtEmail.Text       = dt.Rows[0]["Email"].ToString();
                            
                            DateTime SignupDate = DateTime.Parse(dt.Rows[0]["DateSignedUp"].ToString());
                            lblDate.Text        = SignupDate.AddDays(14).ToString("dd.MM.yyyy");
                        }
                    }
                }
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string UpdateData = "UPDATE KW_Users SET Name = @Name, Address = @Address, Zip = @Zip, City = @City, Telephone = @Telephone, Email = @Email WHERE UserID = " + Int32.Parse(Session["UserID"].ToString());

            using (SqlCommand cmd = new SqlCommand(UpdateData))
            {
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@Zip", txtZip.Text);
                cmd.Parameters.AddWithValue("@City", txtCity.Text);
                cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect("MyProfile.aspx");
            }
        }
    }
}