using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;

namespace Web_PetHouse.Admin
{
	public partial class DanhMuc : System.Web.UI.Page
	{
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
		{
            Session["breadCrumbTitle"] = "Quản lý danh mục";
            Session["breadCrumbPage"] = "Danh Mục";
            lblMsg.Visible = false;

            getCategories();
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
            rCategory.DataSource = dt;
            rCategory.DataBind();
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;

            int categoryId = Convert.ToInt32(hfCategoryId.Value);
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("DanhMuc_crud",con);
            cmd.Parameters.AddWithValue("@HanhDong", categoryId ==0 ?"INSERT":"UPDATE");
            cmd.Parameters.AddWithValue("@MaDanhMuc", categoryId );
            cmd.Parameters.AddWithValue("@TenDanhMuc", txtCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@TrangThai", cbIsActive.Checked);
            if (fuCategoryImage.HasFile)
            {
                if (KetNoi.IsValidExtension(fuCategoryImage.FileName))
                {
                    string newImageName = KetNoi.getUniqueId();
                    fileExtension = Path.GetExtension(fuCategoryImage.FileName);
                    imagePath = "/HinhAnh/DanhMuc/" + newImageName.ToString() + fileExtension;
                    fuCategoryImage.PostedFile.SaveAs(Server.MapPath("~/HinhAnh/DanhMuc/") + newImageName.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@HinhAnhDanhMuc", imagePath);
                    isValidToExecute = true;
                }
                else {
                    lblMsg.Visible = false;
                    lblMsg.Text = "Vui lòng chọn đúng định dạng .jpg, .jpeg or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;

                }
            }
            else
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = categoryId == 0 ? "Thêm" : "Cập nhật";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Danh mục " + actionName + " Thành Công!";
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();
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
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }
        void clear()
        {
            txtCategoryName.Text=string.Empty;
            cbIsActive.Checked = false;
            hfCategoryId.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
            imagePreview.ImageUrl=string.Empty ;
        }

        protected void rCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("DanhMuc_crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "GETBYID");
                cmd.Parameters.AddWithValue("@MaDanhMuc", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtCategoryName.Text = dt.Rows[0]["TenDanhMuc"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["TrangThai"]);
                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["HinhAnhDanhMuc"].ToString()) ? "../HinhAnh/No_image.png" : "../" + dt.Rows[0]["HinhAnhDanhMuc"].ToString();
                imagePreview.Height = 200;
                imagePreview.Width = 200;
                hfCategoryId.Value = dt.Rows[0]["MaDanhMuc"].ToString();
                btnAddOrUpdate.Text = "Cập Nhật";
            }
            if (e.CommandName == "delete")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("DanhMuc_crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "DELETE");
                cmd.Parameters.AddWithValue("@MaDanhMuc", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Xóa danh mục thành công!";
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();
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