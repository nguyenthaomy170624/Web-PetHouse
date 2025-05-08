using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Web_PetHouse.Admin
{
	public partial class SanPham : System.Web.UI.Page
	{
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
		{
            Session["breadCrumbTitle"] = "Quản lý sản phẩm";
            Session["breadCrumbPage"] = "Sản phẩm";
            lblMsg.Visible = false;

            if (!IsPostBack)
            {
                LoadCategories();
                LoadSubCategories();
                GetProducts();
            }
        }
        void LoadCategories()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("SELECT MaDanhMuc, TenDanhMuc FROM DanhMuc WHERE TrangThai = 1", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "TenDanhMuc";
            ddlCategory.DataValueField = "MaDanhMuc";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Chọn danh mục", "0"));
        }
        void LoadSubCategories()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("SELECT MaDanhMucCon, TenDanhMucCon FROM DanhMucCon WHERE TrangThai = 1", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "TenDanhMucCon";
            ddlSubCategory.DataValueField = "MaDanhMucCon";
            ddlSubCategory.DataBind();
            ddlSubCategory.Items.Insert(0, new ListItem("Chọn danh mục con", "0"));
        }

        void GetProducts()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("SanPham_Crud", con);
            cmd.Parameters.AddWithValue("@HanhDong", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int productId = Convert.ToInt32(hfProductId.Value);

            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("SanPham_Crud", con);
            cmd.Parameters.AddWithValue("@HanhDong", productId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@MaSanPham", productId);
            cmd.Parameters.AddWithValue("@TenSanPham", txtProductName.Text.Trim());
            cmd.Parameters.AddWithValue("@MoTaNgan", txtShortDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@MoTaChiTiet", txtDetailDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@MoTaBoSung", DBNull.Value);
            cmd.Parameters.AddWithValue("@Gia", Convert.ToDecimal(txtPrice.Text));
            cmd.Parameters.AddWithValue("@SoLuong", Convert.ToInt32(txtQuantity.Text));
            cmd.Parameters.AddWithValue("@NhaSanXuat", txtManufacturer.Text.Trim());
            cmd.Parameters.AddWithValue("@MaDanhMuc", Convert.ToInt32(ddlCategory.SelectedValue));

            // Sử dụng if-else thay vì toán tử điều kiện
            if (Convert.ToInt32(ddlSubCategory.SelectedValue) > 0)
            {
                cmd.Parameters.AddWithValue("@MaDanhMucCon", Convert.ToInt32(ddlSubCategory.SelectedValue));
            }
            else
            {
                cmd.Parameters.AddWithValue("@MaDanhMucCon", DBNull.Value);
            }

            cmd.Parameters.AddWithValue("@TrangThai", cbIsActive.Checked);

            if (fuProductImage.HasFile)
            {
                try
                {
                    if (KetNoi.IsValidExtension(fuProductImage.FileName))
                    {
                        string newImageName = KetNoi.getUniqueId();
                        fileExtension = Path.GetExtension(fuProductImage.FileName).ToLower();
                        imagePath = "/HinhAnh/" + newImageName + fileExtension;
                        string physicalPath = Server.MapPath("~/HinhAnh/") + newImageName + fileExtension;

                        // Kiểm tra và tạo thư mục /HinhAnh/
                        string directoryPath = Server.MapPath("~/HinhAnh/");
                        if (!Directory.Exists(directoryPath))
                        {
                            Directory.CreateDirectory(directoryPath);
                        }

                        // Lưu ảnh
                        fuProductImage.PostedFile.SaveAs(physicalPath);
                        cmd.Parameters.AddWithValue("@HinhAnhSanPham", imagePath);
                        isValidToExecute = true;
                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Vui lòng chọn đúng định dạng .jpg, .jpeg hoặc .png";
                        lblMsg.CssClass = "alert alert-danger";
                        isValidToExecute = false;
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Lỗi khi lưu ảnh: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                    System.IO.File.AppendAllText(Server.MapPath("~/Logs/error.log"), DateTime.Now + ": Lỗi lưu ảnh: " + ex.ToString() + "\n");
                    isValidToExecute = false;
                }
            }
            else
            {
                cmd.Parameters.AddWithValue("@HinhAnhSanPham", DBNull.Value);
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = productId == 0 ? "Thêm" : "Cập nhật";
                    lblMsg.Visible = true;
                    lblMsg.Text = actionName + " thành công!";
                    lblMsg.CssClass = "alert alert-success";
                    GetProducts();
                    Clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Lỗi khi lưu sản phẩm: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                    System.IO.File.AppendAllText(Server.MapPath("~/Logs/error.log"), DateTime.Now + ": Lỗi lưu sản phẩm: " + ex.ToString() + "\n");
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        void Clear()
        {
            txtProductName.Text = string.Empty;
            txtShortDescription.Text = string.Empty;
            txtDetailDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtManufacturer.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
            cbIsActive.Checked = false;
            hfProductId.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
            imagePreview.ImageUrl = string.Empty;
        }

        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("SanPham_Crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "GETBYID");
                cmd.Parameters.AddWithValue("@MaSanPham", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                txtProductName.Text = dt.Rows[0]["TenSanPham"].ToString();
                txtShortDescription.Text = dt.Rows[0]["MoTaNgan"].ToString();
                txtDetailDescription.Text = dt.Rows[0]["MoTaChiTiet"].ToString();
                txtPrice.Text = dt.Rows[0]["Gia"].ToString();
                txtQuantity.Text = dt.Rows[0]["SoLuong"].ToString();
                txtManufacturer.Text = dt.Rows[0]["NhaSanXuat"].ToString();
                ddlCategory.SelectedValue = dt.Rows[0]["MaDanhMuc"].ToString();
                // Sửa lỗi: Cập nhật giá trị cho ddlSubCategory
                if (!string.IsNullOrEmpty(dt.Rows[0]["MaDanhMucCon"].ToString()))
                {
                    ddlSubCategory.SelectedValue = dt.Rows[0]["MaDanhMucCon"].ToString();
                }
                else
                {
                    ddlSubCategory.SelectedIndex = 0;
                }
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["TrangThai"]);
                // Sửa lỗi: Sử dụng cột HinhAnhSanPham thay vì DuongDanHinhAnh
                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["HinhAnhSanPham"].ToString()) ? "/HinhAnh/No_image.png" : dt.Rows[0]["HinhAnhSanPham"].ToString();
                imagePreview.Height = 200;
                imagePreview.Width = 200;
                hfProductId.Value = dt.Rows[0]["MaSanPham"].ToString();
                btnAddOrUpdate.Text = "Cập Nhật";
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(KetNoi.getConnection());
                cmd = new SqlCommand("SanPham_Crud", con);
                cmd.Parameters.AddWithValue("@HanhDong", "DELETE");
                cmd.Parameters.AddWithValue("@MaSanPham", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Xóa sản phẩm thành công!";
                    lblMsg.CssClass = "alert alert-success";
                    GetProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Lỗi: " + ex.Message;
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
