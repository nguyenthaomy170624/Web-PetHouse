using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.Admin
{
    public partial class KhachHang : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCrumbTitle"] = "Quản lý danh người dùng";
            Session["breadCrumbPage"] = "Người dùng";
            if(!IsPostBack)
            {
                getUsers();
            }    
        }
        void getUsers()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECTADMIN");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rUsers.DataSource = dt;
            rUsers.DataBind();
        }
        protected void rUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Xóa người dùng thành công!";
                    lblMsg.CssClass = "alert alert-success";
                    getUsers();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}