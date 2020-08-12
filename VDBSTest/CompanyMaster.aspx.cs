using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VDBSTest
{
    public partial class CompanyMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            InsertCompanyMaster();
            InsertFileMaster();
        }
        protected void InsertCompanyMaster()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    con.Open();
                    string str = "INSERT INTO CompanyMaster(Name, Status) values " + "('" + txtName.Text + "','" + 0 + "')";
                    SqlCommand cmd = new SqlCommand(str, con);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex) { }
        }

        protected void InsertFileMaster()
        {
            foreach (HttpPostedFile postedFile in FileUpload1.PostedFiles)
            {
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string contentType = FileUpload1.PostedFile.ContentType;
                using (Stream fs = FileUpload1.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        string constr = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                        using (SqlConnection con = new SqlConnection(constr))
                        {
                            string query = "INSERT INTO FileMaster VALUES (@FileName, @ContentType, @CompanyId)";
                            using (SqlCommand cmd = new SqlCommand(query))
                            {
                                cmd.Connection = con;
                                cmd.Parameters.AddWithValue("@FileName", bytes);
                                cmd.Parameters.AddWithValue("@ContentType", contentType);
                                cmd.Parameters.AddWithValue("@CompanyId", getCompanyId());
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }
                }
            }
            Session.Add("FileAdded", "File(s) added Successfully.");
            Response.Redirect("CompanyViewPage.aspx");
        }

        protected int getCompanyId()
        {
            int CompanyId = 0;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string query = "SELECT Id from CompanyMaster where Name=('" + txtName.Text + "')";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                foreach (DataRow dr in dt.Rows) CompanyId = Convert.ToInt32(dr.ItemArray[0]);
            }
            return CompanyId;
        }
    }
}