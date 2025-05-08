using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
    public partial class DangNhap : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] != null)
                {
                    Response.Redirect("/Admin/BangDieuKhien.aspx");
                }
                else if (Session["MaNguoiDung"] != null)
                {
                    Response.Redirect("TrangChu.aspx");
                }

            }

        }
        protected void btnLogin_Click1(object sender, EventArgs e)

        {
            
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowSweetAlert("Thông báo", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!", "warning");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("User_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "SELECTLOGIN");
                        cmd.Parameters.AddWithValue("@TenDangNhap", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@MatKhau", txtPassword.Text.Trim());

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            using (DataTable dt = new DataTable())
                            {
                                sda.Fill(dt);
                                if (dt.Rows.Count == 1)
                                {
                                    int userId = Convert.ToInt32(dt.Rows[0]["MaNguoiDung"]);
                                    int maVaiTro = Convert.ToInt32(dt.Rows[0]["MaVaiTro"]);

                                    if (maVaiTro == 1) 
                                    {
                                        Session["admin"] = txtUsername.Text.Trim();
                                        ShowSweetAlert("Thành công", "Đăng nhập thành công!", "success");
                                        ScriptManager.RegisterStartupScript(this, GetType(), "RedirectScript",
                                            "setTimeout(function() { window.location.href = '/Admin/BangDieuKhien.aspx'; }, 2000);", true);
                                    }
                                    else 
                                    {
                                        Session["MaNguoiDung"] = userId;
                                        Session["TenDangNhap"] = txtUsername.Text.Trim();

                                        ShowSweetAlert("Thành công", "Đăng nhập thành công!", "success");
                                        ScriptManager.RegisterStartupScript(this, GetType(), "RedirectScript",
                                            "setTimeout(function() { window.location.href = 'TrangChu.aspx'; }, 2000);", true);
                                    }

                                    clear();
                                }

                                else
                                {
                                    ShowSweetAlert("Lỗi", "Tài khoản hoặc mật khẩu không chính xác!", "error");
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowSweetAlert("Lỗi", "Đã xảy ra lỗi: " + ex.Message, "error");
            }
        }

        private void ShowSweetAlert(string title, string message, string icon)
        {
            string script = $"Swal.fire('{title}', '{message}', '{icon}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlert", script, true);
        }

        private void clear()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
        }
    }
}

    
