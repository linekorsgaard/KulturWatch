using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class DynamicArticle : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string articleURL = this.Page.RouteData.Values["Headline"].ToString();

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID LEFT JOIN KW_Users ON KW_Articles.FK_UserID = KW_Users.UserID WHERE URL = @URL"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@URL", articleURL);
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;

                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                int ArticleID       = Int32.Parse(dt.Rows[0]["ArticleID"].ToString());
                                lblHeadline.Text    = dt.Rows[0]["Headline"].ToString();
                                lblArticleID.Text   = dt.Rows[0]["ArticleID"].ToString();
                                lblAuthor.Text      = dt.Rows[0]["Name"].ToString();
                                lblDate.Text        = dt.Rows[0]["DatePublished"].ToString();
                                linkCategory.HRef   = "/" + dt.Rows[0]["CategoryURL"].ToString();
                                linkCategory.InnerText = dt.Rows[0]["CategoryName"].ToString();
                                liArticle.InnerText = dt.Rows[0]["Headline"].ToString();
                                Page.Title          = dt.Rows[0]["Headline"].ToString();

                                if (int.Parse(dt.Rows[0]["Locked"].ToString()) == 1 && Session["UserLvl"] == null)
                                {
                                    dt.Rows[0]["BodyText"] = dt.Rows[0]["BodyText"].ToString().Substring(0,250) + "... <i class='fa fa-key'></i>";
                                    phLocked.Visible = true;
                                }

                                lblBodyText.Text    = dt.Rows[0]["BodyText"].ToString();
                                imgImage.ImageUrl   = dt.Rows[0]["ImagePath"].ToString();
                                lblLede.Text        = dt.Rows[0]["Lede"].ToString();
                                linkFB.HRef         = "http://www.facebook.com/sharer.php?u=" + HttpContext.Current.Request.Url.AbsoluteUri.ToString();
                                linkTW.HRef         = "https://twitter.com/intent/tweet?text=" + dt.Rows[0]["Headline"].ToString() + " . Læs mere her: " + HttpContext.Current.Request.Url.AbsoluteUri.ToString() + "&hashtags=kultur,KulturWatch";
                                linkEmail.HRef      = "mailto:?subject=" + dt.Rows[0]["Headline"].ToString() + " &amp;body=Læs det her: " + HttpContext.Current.Request.Url.AbsoluteUri.ToString();

                                getComments(ArticleID);

                                DataTable dtRelated = getRelatedNews(Int32.Parse(dt.Rows[0]["FK_CategoryID"].ToString()));
                                lvRelated.DataSource = dtRelated;
                                lvRelated.DataBind();

                                if (Session["UserLvl"] != null)
                                {
                                    btnSaveArticle.Visible = true;
                                    txtComment.Visible = true;
                                    btnComment.Visible = true;
                                    lblCommentMsg.Visible = false;

                                    if (Int32.Parse(Session["UserLvl"].ToString()) == 1)
                                    {
                                        lvCommentsAdmin.Visible = true;
                                        lvComments.Visible = false;
                                    }
                                }
                            } else
                            {
                                Response.Redirect("/404.aspx");
                            }
                        }
                    }
                }
            }
        }
    }

    DataTable getRelatedNews(int CategoryID)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID WHERE FK_CategoryID = " + CategoryID + " ORDER BY DatePublished desc OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY", con))
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

    protected void btnComment_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {

            using (SqlCommand cmd = new SqlCommand("INSERT INTO KW_Comments VALUES (@Comment, @DateCreated, @FK_UserID, @FK_ArticleID)"))
            {
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@Comment", txtComment.Text);
                cmd.Parameters.AddWithValue("@DateCreated", DateTime.Now);
                cmd.Parameters.AddWithValue("@FK_UserID", Int32.Parse(Session["UserID"].ToString()));
                cmd.Parameters.AddWithValue("@FK_ArticleID", Int32.Parse(lblArticleID.Text));

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }

    protected void getComments(int ArticleID)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmdComments = new SqlCommand("SELECT * FROM KW_Comments JOIN KW_Users ON KW_Comments.FK_UserID = KW_Users.UserID WHERE FK_ArticleID = " + ArticleID + " ORDER BY DateCreated desc"))
            {
                using (SqlDataAdapter sdaComments = new SqlDataAdapter())
                {
                    cmdComments.Connection = con;
                    sdaComments.SelectCommand = cmdComments;

                    using (DataTable dtComments = new DataTable())
                    {
                        sdaComments.Fill(dtComments);

                        if (dtComments.Rows.Count > 0)
                        {
                            lvComments.DataSource = dtComments;
                            lvComments.DataBind();

                            lvCommentsAdmin.DataSource = dtComments;
                            lvCommentsAdmin.DataBind();
                        }
                    }
                }
            }
        }
    }

    public void deleteComment(Object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand deleteComment = new SqlCommand("DELETE FROM KW_Comments WHERE CommentID =" + (sender as Button).CommandArgument, con);

            con.Open();
            deleteComment.ExecuteNonQuery();
            con.Close();

            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}