using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;


public partial class _Default : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID ORDER BY DatePublished desc", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            if (Int32.Parse(dt.Rows[0]["Locked"].ToString()) == 1)
                            {
                                dt.Rows[0]["Headline"] = dt.Rows[0]["Headline"].ToString() + " <i class='fa fa-key'></i>";
                            }

                            string Link = "/" + dt.Rows[0]["CategoryURL"].ToString() + "/" + dt.Rows[0]["URL"].ToString() + ".aspx";

                            imgTopNews1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
                            lblTopNews1Heading.Text = dt.Rows[0]["Headline"].ToString();
                            lblTopNews1Lede.Text = dt.Rows[0]["Lede"].ToString();
                            linkTopNews.HRef = Link;
                            linkTopNews1.HRef = Link;

                            DataTable dtRelated = getRelatedNews(Int32.Parse(dt.Rows[0]["FK_CategoryID"].ToString()));

                            foreach (DataRow rowRelated in dtRelated.Rows)
                            {
                                if (Int32.Parse(rowRelated["Locked"].ToString()) == 1)
                                {
                                    rowRelated["Headline"] = rowRelated["Headline"].ToString() + " <i class='fa fa-key'></i>";
                                }
                            }

                            lvRelated.DataSource = dtRelated;
                            lvRelated.DataBind();

                            DataTable dtTopNews = getTopNews();

                            foreach (DataRow rowTopNews in dtTopNews.Rows)
                            {
                                if (Int32.Parse(rowTopNews["Locked"].ToString()) == 1)
                                {
                                    rowTopNews["Headline"] = rowTopNews["Headline"].ToString() + " <i class='fa fa-key'></i>";
                                }
                            }

                            lvTopNews.DataSource = dtTopNews;
                            lvTopNews.DataBind();

                            int CategoryID = getLastCategory();
                            DataTable dtLatestNews = getLatestNewsByCategory(CategoryID);

                            foreach (DataRow rowTopNews in dtTopNews.Rows)
                            {
                                if (Int32.Parse(rowTopNews["Locked"].ToString()) == 1)
                                {
                                    rowTopNews["Headline"] = rowTopNews["Headline"].ToString() + " <i class='fa fa-key'></i>";
                                }
                            }

                            if (dtLatestNews.Rows.Count > 0)
                            {
                                lblLatestHeadline.Text = dtLatestNews.Rows[0]["CategoryName"].ToString().ToLower();
                                lvLatestCategory.DataSource = dtLatestNews;
                                lvLatestCategory.DataBind();
                                phLatest.Visible = true;
                                linkLatest.HRef = "/" + dtLatestNews.Rows[0]["CategoryURL"].ToString();
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

    DataTable getTopNews()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID ORDER BY DatePublished desc OFFSET 1 ROWS FETCH NEXT 4 ROWS ONLY", con))
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

    int getLastCategory()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT CategoryID FROM KW_Categories ORDER BY Sort desc", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    return Int32.Parse(dt.Rows[0]["CategoryID"].ToString());
                }
            }
        }
    }

    DataTable getLatestNewsByCategory(int CategoryID)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT TOP 4 * FROM KW_Articles LEFT JOIN KW_Categories ON KW_Articles.FK_CategoryID = KW_Categories.CategoryID WHERE FK_CategoryID = " + CategoryID + " ORDER BY DatePublished desc", con))
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
}