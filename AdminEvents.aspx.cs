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

public partial class AdminEvents : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        CompareValidator1.ValueToCompare = DateTime.Now.ToShortDateString();
        CompareValidator2.ValueToCompare = DateTime.Now.ToShortDateString();

        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserLvl"].ToString() == "1")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Events LEFT JOIN KW_EventStatus ON KW_Events.FK_EventStatus = KW_EventStatus.EventStatusID"))
                    {
                        cmd.Connection = con;

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            lvEvents.DataSource = dt;
                            lvEvents.DataBind();
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

    protected void btnNewEvent_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string InsertData = "INSERT INTO KW_Events VALUES (@EventName, @Description, @DateStart, @DateEnd, @Price, @ReducedPrice , @FK_EventStatus, @FK_UserID, @URL)";

                using (SqlCommand cmd = new SqlCommand(InsertData))
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
                    cmd.Parameters.AddWithValue("@Description", txtEventDescription.Text);
                    cmd.Parameters.AddWithValue("@DateStart", txtEventStart.Text);
                    cmd.Parameters.AddWithValue("@DateEnd", txtEventEnd.Text);
                    cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                    cmd.Parameters.AddWithValue("@ReducedPrice", txtReducedPrice.Text);
                    cmd.Parameters.AddWithValue("@FK_EventStatus", 2);
                    cmd.Parameters.AddWithValue("@FK_UserID", Int32.Parse(Session["UserID"].ToString()));
                    cmd.Parameters.AddWithValue("@URL", Regex.Replace(txtEventName.Text, @"[^A-Za-z0-9_\.~]+", "-").ToLower());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }
    }

    public void declineEvent(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string UpdateData = "UPDATE KW_Events SET FK_EventStatus = 3 WHERE EventID = " + (sender as Button).CommandArgument;

            using (SqlCommand cmd = new SqlCommand(UpdateData))
            {
                cmd.Connection = con;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }

    public void approveEvent(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string UpdateData = "UPDATE KW_Events SET FK_EventStatus = 2 WHERE EventID = " + (sender as Button).CommandArgument;

            using (SqlCommand cmd = new SqlCommand(UpdateData))
            {
                cmd.Connection = con;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }

    public void deleteEvent(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand DeleteEvent = new SqlCommand("DELETE FROM KW_Events WHERE EventID=" + (sender as Button).CommandArgument, con);

            con.Open();
            DeleteEvent.ExecuteNonQuery();
            con.Close();

            Response.Redirect("/AdminEvents.aspx");
        }
    }
}