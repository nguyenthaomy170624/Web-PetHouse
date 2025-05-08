using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
namespace Web_PetHouse.Admin
{
	public partial class DanhMucCon : System.Web.UI.Page
	{
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCrumbTitle"] = "Quản lý danh mục con";
            Session["breadCrumbPage"] = "Danh Mục Con";
            if(!IsPostBack)
            {

                getCategories();
                getSubCategories();


            }
            lblMsg.Visible = false;
            
        }
        void getCategories()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("DanhMuc_Crud", con);
            cmd.Parameters.AddWithValue("@HanhDong", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "TenDanhMuc";
            ddlCategory.DataValueField = "MaDanhMuc";
            ddlCategory.DataBind();

        }
        void getSubCategories()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("DanhMucCon_Crud", con);
            cmd.Parameters.AddWithValue("@HanhDong", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rSubCategory.DataSource = dt;
            rSubCategory.DataBind();
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty;

            int subcategoryId = Convert.ToInt32(hfSubCategoryId.Value);
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("DanhMucCon_crud", con);
            cmd.Parameters.AddWithValue("@HanhDong", subcategoryId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@MaDanhMucCon", subcategoryId);
            cmd.Parameters.AddWithValue("@TenDanhMucCon", txtSubCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@MaDanhMuc", Convert.ToInt32( ddlCategory.SelectedValue));
            cmd.Parameters.AddWithValue("@TrangThai", cbIsActive.Checked);                
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                actionName = subcategoryId == 0 ? "Thêm" : "Cập nhật";
                lblMsg.Visible = true;
                lblMsg.Text = " Danh mục con" + actionName + " Thành Công!";
                lblMsg.CssClass = "alert alert-success";
                getSubCategories();
                clear();
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Enrol- " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";

            }
            finally { con.Close(); }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }
        void clear()
        {
            txtSubCategoryName.Text = string.Empty;
            cbIsActive.Checked = false;
            hfSubCategoryId.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
            ddlCategory.ClearSelection();
        }

        protected void rSubCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("DanhMucCon_crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "GETBYID");
                cmd.Parameters.AddWithValue("@MaDanhMucCon", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtSubCategoryName.Text = dt.Rows[0]["TenDanhMucCon"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["TrangThai"]);
                ddlCategory.SelectedValue = dt.Rows[0]["MaDanhMuc"].ToString();                
                hfSubCategoryId.Value = dt.Rows[0]["MaDanhMucCon"].ToString();
                btnAddOrUpdate.Text = "Cập nhật";
            }
            if (e.CommandName == "delete")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("DanhMucCon_crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "DELETE");
                cmd.Parameters.AddWithValue("@MaDanhMucCon", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Xóa danh mục con thành công!";
                    lblMsg.CssClass = "alert alert-success";
                    getSubCategories();
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