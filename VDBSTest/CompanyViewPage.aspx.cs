using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VDBSTest
{
    public partial class CompanyViewPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FileAdded"] != null)
            {
                lblMsg.Text = Session["FileAdded"].ToString();
                Session["FileAdded"] = null;
            }
            else
            {
                lblMsg.Text = "";
            }
            if (!Page.IsPostBack)
            {
                BindGridview();
            }
        }

        protected void BindGridview()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM CompanyMaster", con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    con.Close();
                    gridFile.DataSource = ds;
                    gridFile.DataBind();
                    foreach (GridViewRow row in gridFile.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            Button btnShow = row.FindControl("btnShow") as Button;
                            Button btnApproveDisapprove = row.FindControl("btnApproveDisapprove") as Button;
                            Label lblstatus = row.FindControl("lblstatus") as Label;
                            if (lblstatus.Text == "False")
                            {
                                btnShow.Enabled = false;
                                btnApproveDisapprove.Enabled = false;
                            }
                            else
                            {
                                btnShow.Enabled = true;
                                btnApproveDisapprove.Enabled = true;
                            }
                        }
                    }
                }
            }
            catch { }
        }

        protected void gridFile_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Show")
                {

                    int id = Convert.ToInt32(e.CommandArgument);
                    Session.Add("CompanyId", id); 
                    string title = "Download Files"; 
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup('" + title + "');", true);
                }
                if (e.CommandName == "ApproveDisapprove")
                { 
                    int id = Convert.ToInt32(e.CommandArgument);
                    ViewState.Add("AppDisAppId", id);
                    string title = "Approve/ Disapprove";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup1('" + title + "');", true);
                } 
            }
            catch (Exception ex) { }
        }

        protected void btnAppr_Click(object sender, EventArgs e)
        {
            ViewState.Add("StatusApp", 1);
            UpdateStatusCompany();
            BindGridview();
        }

        protected void btnDisAppr_Click(object sender, EventArgs e)
        {
            ViewState.Add("StatusDisApp", 0);
            UpdateStatusCompany();
            BindGridview();
        }

        protected void UpdateStatusCompany()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    con.Open();
                    string str = null;
                    if (ViewState["StatusApp"] != null)
                    {
                        str = "update CompanyMaster set Status= " + 1 + " where id=" + Convert.ToInt32(ViewState["AppDisAppId"]);
                        ViewState["StatusApp"] = null;
                    }
                    if (ViewState["StatusDisApp"] != null)
                    {
                        str = "update CompanyMaster set Status= " + 0 + " where id=" + Convert.ToInt32(ViewState["AppDisAppId"]);
                        ViewState["StatusDisApp"] = null;
                    }
                    SqlCommand cmd = new SqlCommand(str, con);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex) { }
        }
    }
}