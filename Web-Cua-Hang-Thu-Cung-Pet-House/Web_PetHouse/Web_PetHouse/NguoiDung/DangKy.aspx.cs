using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

namespace Web_PetHouse.NguoiDung
{
    public partial class DangKy : System.Web.UI.Page
    {
        private bool IsEditMode
        {
            get
            {
                return ViewState["IsEditMode"] != null ? (bool)ViewState["IsEditMode"] : false;
            }
            set
            {
                ViewState["IsEditMode"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Request.QueryString["id"] != null)
                    {
                        IsEditMode = true;
                        int userId;
                        if (!int.TryParse(Request.QueryString["id"], out userId))
                        {
                            throw new Exception("ID người dùng không hợp lệ.");
                        }

                        if (Session["MaNguoiDung"] == null || userId != Convert.ToInt32(Session["MaNguoiDung"]))
                        {
                            Response.Redirect("DangNhap.aspx");
                        }

                        lblTitle.Text = "Chỉnh sửa thông tin";
                        btnRegister.Text = "Cập nhật";
                        lblAlreadyUser.Visible = false;
                        txtPassword.Visible = false;
                        rfvPassword.Enabled = false;
                        LoadUserData(userId);
                    }
                    else
                    {
                        IsEditMode = false;
                        lblTitle.Text = "Đăng ký người dùng";
                        btnRegister.Text = "Đăng ký";
                        lblAlreadyUser.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    string errorMessage = HttpUtility.JavaScriptStringEncode(ex.Message);
                    string errorScript = $@"
                        Swal.fire({{
                            title: 'Lỗi!',
                            html: 'Có lỗi xảy ra khi tải trang: <b>{errorMessage}</b>',
                            icon: 'error'
                        }});
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
                }
            }
        }

        private void LoadUserData(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    SqlCommand cmd = new SqlCommand("User_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "SELECTPROFILE");
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        txtName.Text = dt.Rows[0]["HoTen"].ToString();
                        txtUsername.Text = dt.Rows[0]["TenDangNhap"].ToString();
                        txtEmail.Text = dt.Rows[0]["Email"].ToString();
                        txtMobile.Text = dt.Rows[0]["SoDienThoai"].ToString();
                        txtAddress.Text = dt.Rows[0]["DiaChi"].ToString();
                        txtPostCode.Text = dt.Rows[0]["MaBuuDien"].ToString();

                        string imageUrl = dt.Rows[0]["HinhAnh"].ToString();
                        if (!string.IsNullOrEmpty(imageUrl))
                        {
                            imgUser.ImageUrl = Web_PetHouse.KetNoi.getImageUrl(imageUrl);
                            imgUser.Visible = true;
                            lblImageNote.Visible = true;
                        }
                    }
                    else
                    {
                        throw new Exception("Không tìm thấy người dùng với ID: " + userId);
                    }
                }
            }
            catch (Exception ex)
            {
                string errorMessage = HttpUtility.JavaScriptStringEncode(ex.Message);
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi tải thông tin người dùng: <b>{errorMessage}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                string errorScript = @"
                    Swal.fire({
                        title: 'Lỗi!',
                        html: 'Vui lòng điền đầy đủ các trường bắt buộc.',
                        icon: 'error'
                    });
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ValidationError", errorScript, true);
                return;
            }

            if (IsEditMode)
            {
                UpdateUser();
            }
            else
            {
                RegisterUser();
            }
        }

        private void RegisterUser()
        {
            try
            {
                string imagePath = null;
                if (fuUserImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuUserImage.PostedFile.FileName);
                    string filePath = Server.MapPath("/NguoiDungTemplate/HinhAnh/") + fileName;
                    fuUserImage.SaveAs(filePath);
                    imagePath = fileName;
                }

                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    SqlCommand checkDuplicateCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE TenDangNhap = @TenDangNhap OR Email = @Email", con);
                    checkDuplicateCmd.Parameters.AddWithValue("@TenDangNhap", txtUsername.Text.Trim());
                    checkDuplicateCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    con.Open();
                    int duplicateCount = (int)checkDuplicateCmd.ExecuteScalar();
                    con.Close();

                    if (duplicateCount > 0)
                    {
                        SqlCommand checkUsernameCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE TenDangNhap = @TenDangNhap", con);
                        checkUsernameCmd.Parameters.AddWithValue("@TenDangNhap", txtUsername.Text.Trim());
                        con.Open();
                        int usernameCount = (int)checkUsernameCmd.ExecuteScalar();
                        con.Close();

                        SqlCommand checkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE Email = @Email", con);
                        checkEmailCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        con.Open();
                        int emailCount = (int)checkEmailCmd.ExecuteScalar();
                        con.Close();

                        string errorMessage = "";
                        if (usernameCount > 0)
                        {
                            errorMessage += "Tên đăng nhập đã tồn tại. ";
                        }
                        if (emailCount > 0)
                        {
                            errorMessage += "Email đã tồn tại.";
                        }
                        throw new Exception(errorMessage.Trim());
                    }

                    SqlCommand cmd = new SqlCommand("User_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@HoTen", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@TenDangNhap", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@DiaChi", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@MaBuuDien", txtPostCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@MatKhau", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@HinhAnh", (object)imagePath ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MaVaiTro", 1);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    string successScript = @"
                        Swal.fire({
                            title: 'Thành công!',
                            html: 'Đăng ký thành công! Bạn sẽ được chuyển hướng đến trang đăng nhập.',
                            icon: 'success'
                        }).then(() => { window.location.href = 'DangNhap.aspx'; });
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert", successScript, true);
                }
            }
            catch (Exception ex)
            {
                string errorMessage = HttpUtility.JavaScriptStringEncode(ex.Message);
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi đăng ký: <b>{errorMessage}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }

        private void UpdateUser()
        {
            try
            {
                int userId;
                if (!int.TryParse(Request.QueryString["id"], out userId))
                {
                    throw new Exception("ID người dùng không hợp lệ.");
                }

                string imagePath = null;
                if (fuUserImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuUserImage.PostedFile.FileName);
                    string filePath = Server.MapPath("~/NguoiDungTemplate/HinhAnh/") + fileName;
                    fuUserImage.SaveAs(filePath);
                    imagePath = fileName;
                }

                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    SqlCommand checkCmd = new SqlCommand("User_Crud", con);
                    checkCmd.Parameters.AddWithValue("@Action", "SELECTPROFILE");
                    checkCmd.Parameters.AddWithValue("@UserId", userId);
                    checkCmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sda = new SqlDataAdapter(checkCmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        throw new Exception("Không tìm thấy người dùng với ID: " + userId);
                    }

                    int maVaiTro = Convert.ToInt32(dt.Rows[0]["MaVaiTro"]);

                    string newUsername = txtUsername.Text.Trim();
                    string newEmail = txtEmail.Text.Trim();

                    SqlCommand checkDuplicateCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE (TenDangNhap = @TenDangNhap OR Email = @Email) AND MaNguoiDung != @UserId", con);
                    checkDuplicateCmd.Parameters.AddWithValue("@TenDangNhap", newUsername);
                    checkDuplicateCmd.Parameters.AddWithValue("@Email", newEmail);
                    checkDuplicateCmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    int duplicateCount = (int)checkDuplicateCmd.ExecuteScalar();
                    con.Close();

                    if (duplicateCount > 0)
                    {
                        SqlCommand checkUsernameCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE TenDangNhap = @TenDangNhap AND MaNguoiDung != @UserId", con);
                        checkUsernameCmd.Parameters.AddWithValue("@TenDangNhap", newUsername);
                        checkUsernameCmd.Parameters.AddWithValue("@UserId", userId);
                        con.Open();
                        int usernameCount = (int)checkUsernameCmd.ExecuteScalar();
                        con.Close();

                        SqlCommand checkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM NguoiDung WHERE Email = @Email AND MaNguoiDung != @UserId", con);
                        checkEmailCmd.Parameters.AddWithValue("@Email", newEmail);
                        checkEmailCmd.Parameters.AddWithValue("@UserId", userId);
                        con.Open();
                        int emailCount = (int)checkEmailCmd.ExecuteScalar();
                        con.Close();

                        string errorMessage = "";
                        if (usernameCount > 0)
                        {
                            errorMessage += "Tên đăng nhập đã tồn tại. ";
                        }
                        if (emailCount > 0)
                        {
                            errorMessage += "Email đã tồn tại.";
                        }
                        throw new Exception(errorMessage.Trim());
                    }

                    SqlCommand cmd = new SqlCommand("User_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "UPDATE");
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@HoTen", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@TenDangNhap", newUsername);
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", newEmail);
                    cmd.Parameters.AddWithValue("@DiaChi", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@MaBuuDien", txtPostCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@HinhAnh", (object)imagePath ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MaVaiTro", maVaiTro);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rowsAffected == 0)
                    {
                        throw new Exception("Không có bản ghi nào được cập nhật. Vui lòng kiểm tra lại.");
                    }

                    string successScript = @"
                        Swal.fire({
                            title: 'Thành công!',
                            html: 'Cập nhật thông tin thành công!',
                            icon: 'success'
                        }).then(() => { window.location.href = 'ThongTin.aspx?updated=true'; });
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert", successScript, true);
                }
            }
            catch (Exception ex)
            {
                string errorMessage = HttpUtility.JavaScriptStringEncode(ex.Message);
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi cập nhật thông tin: <b>{errorMessage}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }
    }
}