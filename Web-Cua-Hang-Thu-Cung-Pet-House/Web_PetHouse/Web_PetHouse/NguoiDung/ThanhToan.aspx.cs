using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Web_PetHouse.NguoiDung
{
    public partial class ThanhToan : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MaNguoiDung"] == null)
                {
                    Response.Redirect("DangNhap.aspx");
                    return;
                }

                BindCartSummary();
                lblTongTien.Text = (GetCartTotal() + 50000).ToString("N0") + "đ";
            }

        }
        private void BindCartSummary()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Cart_Crud", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);

                    DataTable dtCart = new DataTable();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dtCart);
                    }

                    if (dtCart.Rows.Count > 0)
                    {
                        if (!dtCart.Columns.Contains("TongTien"))
                        {
                            dtCart.Columns.Add("TongTien", typeof(decimal));
                            foreach (DataRow row in dtCart.Rows)
                            {
                                row["TongTien"] = Convert.ToDecimal(row["Gia"]) * Convert.ToDecimal(row["SoLuong"]);
                            }
                        }

                        rptCartSummary.DataSource = dtCart;
                        rptCartSummary.DataBind();
                    }
                    else
                    {
                        Response.Redirect("GioHang.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "BindCartSummary");
                ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                    $"window.showErrorAlert('Lỗi khi tải giỏ hàng: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }

        private decimal GetCartTotal()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Cart_Crud", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);

                    DataTable dtCart = new DataTable();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dtCart);
                    }

                    if (dtCart.Rows.Count > 0)
                    {
                        if (!dtCart.Columns.Contains("TongTien"))
                        {
                            dtCart.Columns.Add("TongTien", typeof(decimal));
                            foreach (DataRow row in dtCart.Rows)
                            {
                                row["TongTien"] = Convert.ToDecimal(row["Gia"]) * Convert.ToDecimal(row["SoLuong"]);
                            }
                        }
                        return dtCart.AsEnumerable().Sum(row => Convert.ToDecimal(row["TongTien"]));
                    }
                    return 0;
                }
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "GetCartTotal");
                return 0;
            }
        }



        protected void lbVnPaySubmit_Click(object sender, EventArgs e)
        {
            try
            {
                LogError("lbVnPaySubmit_Click started", "Debug");
                Page.Validate("MainForm");
                if (!Page.IsValid)
                {
                    LogError("Validation failed for VNPay payment", "Debug");
                    ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                        "window.showErrorAlert('Vui lòng điền đầy đủ thông tin hợp lệ.');", true);
                    return;
                }

                if (Session["MaNguoiDung"] == null)
                {
                    LogError("User not logged in, redirecting to DangNhap.aspx", "Debug");
                    Response.Redirect("DangNhap.aspx");
                    return;
                }

                int insertedId;
                LogError("Calling SavePayment for VNPay", "Debug");
                if (SavePayment("vnpay", null, null, null, null, GetFullAddress(), out insertedId))
                {
                    LogError($"SavePayment successful, generating VNPay URL for payment ID: {insertedId}", "Debug");
                    string url = GenerateVnPayUrl(insertedId);
                    LogError($"Redirecting to VNPay URL: {url}", "Debug");
                    Response.Redirect(url);
                }
                else
                {
                    LogError("SavePayment failed for VNPay", "Debug");
                }
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "lbVnPaySubmit_Click");
                ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                    $"window.showErrorAlert('Lỗi khi xử lý thanh toán VNPay: {ex.Message.Replace("'", "\\'")}');", true);
            }

        }

        protected void lbCod_Click(object sender, EventArgs e)
        {
            try
            {
                LogError("lbCod_Click started", "Debug");
                // Validate main form and COD-specific fields
                Page.Validate("MainForm");
                Page.Validate("CODPayment");
                if (!Page.IsValid)
                {
                    LogError("Validation failed for COD payment", "Debug");
                    ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                        "window.showErrorAlert('Vui lòng điền đầy đủ thông tin hợp lệ.');", true);
                    return;
                }

                if (string.IsNullOrEmpty(txtCODAddress.Text.Trim()))
                    throw new Exception("Vui lòng nhập địa chỉ nhận hàng.");

                LogError("Calling SavePayment for COD", "Debug");
                SavePayment("cod", null, null, null, null, txtCODAddress.Text);
                LogError("lbCod_Click completed successfully", "Debug");
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "lbCod_Click");
                ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                    $"window.showErrorAlert('Lỗi khi xử lý thanh toán COD: {ex.Message.Replace("'", "\\'")}');", true);
            }

        }

        protected void lbCard_Click(object sender, EventArgs e)
        {
            try
            {
                LogError("lbCard_Click started", "Debug");
                // Validate main form and card-specific fields
                Page.Validate("MainForm");
                Page.Validate("CardPayment");
                if (!Page.IsValid)
                {
                    LogError("Validation failed for card payment", "Debug");
                    ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                        "window.showErrorAlert('Vui lòng điền đầy đủ thông tin hợp lệ.');", true);
                    return;
                }

                if (string.IsNullOrEmpty(txtName.Text.Trim()))
                    throw new Exception("Vui lòng nhập tên chủ thẻ.");

                string cardNo = txtCardNo.Text.Trim();
                if (cardNo.Length != 16 || !long.TryParse(cardNo, out _))
                    throw new Exception("Số thẻ phải là 16 chữ số.");

                cardNo = $"************{cardNo.Substring(12, 4)}";
                string expiryDate = $"{txtExpMonth.Text.Trim()}/{txtExpYear.Text.Trim()}";
                if (!int.TryParse(txtExpMonth.Text.Trim(), out int month) || month < 1 || month > 12)
                    throw new Exception("Tháng hết hạn không hợp lệ (01-12).");
                if (!int.TryParse(txtExpYear.Text.Trim(), out int year) || year < DateTime.Now.Year)
                    throw new Exception("Năm hết hạn không hợp lệ (phải lớn hơn hoặc bằng năm hiện tại).");

                if (!int.TryParse(txtCvv.Text.Trim(), out int cvv) || txtCvv.Text.Trim().Length != 3)
                    throw new Exception("CVV phải là 3 chữ số.");

                LogError("Calling SavePayment for card", "Debug");
                SavePayment("card", txtName.Text, cardNo, expiryDate, cvv.ToString(), GetFullAddress());
                LogError("lbCard_Click completed successfully", "Debug");
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "lbCard_Click");
                ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                    $"window.showErrorAlert('Lỗi khi xử lý thanh toán thẻ: {ex.Message.Replace("'", "\\'")}');", true);
            }

        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openPaymentModal();", true);

        }
         private string GetFullAddress()
        {
            return $"{txtAddress1.Text.Trim()}" +
                   $", {txtCity.Text.Trim()}, {txtState.Text.Trim()}" +
                   (string.IsNullOrEmpty(txtZipCode.Text) ? "" : $", {txtZipCode.Text.Trim()}");
        }

        private void SavePayment(string method, string cardName, string cardNo, string expiry, string cvv, string address)
        {
            int insertedId;
            if (SavePayment(method, cardName, cardNo, expiry, cvv, address, out insertedId))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "successScript",
                    $"window.showSuccessAlert('Thanh toán thành công!', 'HoaDon.aspx?id={insertedId}');", true);
            }
        }

        private bool SavePayment(string method, string cardName, string cardNo, string expiry, string cvv, string address, out int insertedId)
        {
            insertedId = 0;
            SqlConnection con = null;
            SqlTransaction transaction = null;
            DataTable dt = new DataTable();
            string vnp_TxnRef = null; // Khởi tạo vnp_TxnRef

            dt.Columns.AddRange(new DataColumn[7]
            {
        new DataColumn("MaDonHang", typeof(string)),
        new DataColumn("MaSanPham", typeof(int)),
        new DataColumn("SoLuong", typeof(int)),
        new DataColumn("MaNguoiDung", typeof(int)),
        new DataColumn("TrangThai", typeof(string)),
        new DataColumn("MaThanhToan", typeof(int)),
        new DataColumn("NgayDatHang", typeof(DateTime))
            });

            try
            {
                con = new SqlConnection(KN.GetConnectionString());
                con.Open();
                transaction = con.BeginTransaction();

                string hoTenDayDu = $"{txtFirstName.Text.Trim()} {txtLastName.Text.Trim()}";
                string email = txtEmail.Text.Trim();
                string soDienThoai = txtPhone.Text.Trim();

                if (string.IsNullOrEmpty(hoTenDayDu) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(soDienThoai) || string.IsNullOrEmpty(txtAddress1.Text.Trim()))
                {
                    throw new Exception("Vui lòng điền đầy đủ thông tin thanh toán (Họ tên, Email, Số điện thoại, Địa chỉ).");
                }

                if (!new[] { "card", "cod", "vnpay" }.Contains(method))
                {
                    throw new Exception("Phương thức thanh toán không hợp lệ.");
                }

                // Tạo vnp_TxnRef cho VNPay
                if (method == "vnpay")
                {
                    vnp_TxnRef = KetNoi.GetUniqueId();
                    LogError($"Generated vnp_TxnRef for VNPay: {vnp_TxnRef}", "SavePayment");
                }

                // 1. Lưu thanh toán
                using (SqlCommand cmd = new SqlCommand("Save_Payment", con, transaction))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CardNo", (object)cardNo ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ExpiryDate", (object)expiry ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Cvv", (object)cvv ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Address", method == "cod" ? address : GetFullAddress());
                    cmd.Parameters.AddWithValue("@PaymentMode", method);
                    cmd.Parameters.AddWithValue("@HoTenDayDu", hoTenDayDu);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoai);
                    cmd.Parameters.AddWithValue("@VnpTxnRef", (object)vnp_TxnRef ?? DBNull.Value); // Lưu vnp_TxnRef

                    SqlParameter insertedIdParam = new SqlParameter("@InsertedId", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(insertedIdParam);

                    cmd.ExecuteNonQuery();
                    insertedId = Convert.ToInt32(insertedIdParam.Value);
                }

                // 2. Lấy giỏ hàng ra DataTable
                DataTable dtCart = new DataTable();
                using (SqlCommand cmd = new SqlCommand("Cart_Crud", con, transaction))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dtCart);
                    }
                }

                // 3. Duyệt và tạo đơn hàng
                string sharedOrderId = KetNoi.GetUniqueId();
                foreach (DataRow row in dtCart.Rows)
                {
                    int productId = Convert.ToInt32(row["MaSanPham"]);
                    int quantity = Convert.ToInt32(row["SoLuong"]);

                    UpdateQuantity(productId, quantity, transaction, con);
                    LogError($"Deleting cart item: ProductId={productId}, UserId={Session["MaNguoiDung"]}", "Debug");
                    DeleteCartItem(productId, transaction, con);

                    dt.Rows.Add(sharedOrderId, productId, quantity, (int)Session["MaNguoiDung"], "Đang xử lý", insertedId, DateTime.Now);
                }

                if (dt.Rows.Count > 0)
                {
                    using (SqlCommand cmd = new SqlCommand("Save_Orders", con, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DonHang", dt);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    throw new Exception("Giỏ hàng rỗng, không thể tạo đơn hàng.");
                }

                transaction.Commit();
                LogError("Transaction committed, updating cart count", "Debug");
                UpdateCartCount((int)Session["MaNguoiDung"]);
                return true;
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "SavePayment");
                try
                {
                    transaction?.Rollback();
                    LogError("Transaction rolled back", "Debug");
                }
                catch (Exception rollbackEx)
                {
                    LogError(rollbackEx.Message, "SavePayment_Rollback");
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "errorScript",
                    $"window.showErrorAlert('Lỗi khi xử lý thanh toán: {ex.Message.Replace("'", "\\'")}');", true);
                return false;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        private void UpdateQuantity(int productId, int quantity, SqlTransaction transaction, SqlConnection con)
        {
            using (SqlCommand cmd = new SqlCommand("SELECT SoLuong, SoLuongDaBan FROM SanPham WHERE MaSanPham = @ProductId", con, transaction))
            {
                cmd.Parameters.AddWithValue("@ProductId", productId);

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        int dbQuantity = (int)dr["SoLuong"];
                        int soldQuantity = dr["SoLuongDaBan"] != DBNull.Value ? (int)dr["SoLuongDaBan"] : 0;
                        int availableQuantity = dbQuantity - soldQuantity;

                        if (availableQuantity < quantity)
                        {
                            throw new Exception($"Sản phẩm ID {productId} không đủ hàng. Số lượng tồn: {availableQuantity}, Số lượng yêu cầu: {quantity}");
                        }
                    }
                    else
                    {
                        throw new Exception($"Sản phẩm ID {productId} không tồn tại.");
                    }
                }
            }

            using (SqlCommand cmd = new SqlCommand("UPDATE SanPham SET SoLuongDaBan = ISNULL(SoLuongDaBan, 0) + @Quantity WHERE MaSanPham = @ProductId", con, transaction))
            {
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.ExecuteNonQuery();
            }
        }

        private void DeleteCartItem(int productId, SqlTransaction transaction, SqlConnection con)
        {
            using (SqlCommand cmd = new SqlCommand("Cart_Crud", con, transaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                cmd.ExecuteNonQuery();
            }
        }

        private void UpdateCartCount(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "GET_CART_COUNT");
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        int cartCount = Convert.ToInt32(cmd.ExecuteScalar());
                        Session["cartCount"] = cartCount;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex.Message, "UpdateCartCount");
            }
        }
        private string GenerateVnPayUrl(int paymentId)
        {
            string vnp_Returnurl = "https://172a-2001-ee0-52ec-e9d0-8573-197e-c718-88ff.ngrok-free.app/NguoiDung/VNPayReturn.aspx";
            string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
            string vnp_TmnCode = "SPHW8KIG";
            string vnp_HashSecret = "TS1LG8D8VAIWV4P9B0L4EYRV1AK27JTH";

            decimal cartTotal = GetCartTotal();
            decimal totalAmount = cartTotal + 50000;
            string vnp_Amount = ((int)(totalAmount * 100)).ToString();
            LogError($"CartTotal: {cartTotal}, TotalAmount: {totalAmount}, vnp_Amount: {vnp_Amount}", "GenerateVnPayUrl");

            string orderId = KetNoi.GetUniqueId();
            string vnp_TxnRef = orderId;
            string vnp_OrderInfo = $"Thanh_toan_don_hang_{orderId}"; 

            VnPayLibrary vnpay = new VnPayLibrary();
            vnpay.AddRequestData("vnp_Version", "2.1.0");
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", vnp_Amount);
            string createDate = DateTime.UtcNow.AddHours(7).ToString("yyyyMMddHHmmss");
            vnpay.AddRequestData("vnp_CreateDate", createDate);
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", HttpContext.Current.Request.UserHostAddress ?? "127.0.0.1");
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", vnp_OrderInfo);
            vnpay.AddRequestData("vnp_OrderType", "billpayment");
            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", vnp_TxnRef);
            vnpay.AddRequestData("vnp_PaymentId", paymentId.ToString());

            LogError($"VNPay Params: Amount={vnp_Amount}, TxnRef={vnp_TxnRef}, OrderInfo={vnp_OrderInfo}, CreateDate={createDate}, PaymentId={paymentId}", "GenerateVnPayUrl");

            return vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
        }

        public class VnPayLibrary
        {
            private SortedList<string, string> _requestData = new SortedList<string, string>(new VnPayCompare());

            public void AddRequestData(string key, string value)
            {
                if (!string.IsNullOrEmpty(value))
                {
                    _requestData.Add(key, value);
                }
            }

            public string CreateRequestUrl(string baseUrl, string vnp_HashSecret)
            {
                StringBuilder data = new StringBuilder();
                StringBuilder hashData = new StringBuilder();
                foreach (var kv in _requestData)
                {
                    if (!string.IsNullOrEmpty(kv.Value))
                    {
                        data.Append($"{kv.Key}={Uri.EscapeDataString(kv.Value)}&"); // Mã hóa URL cho query string
                        hashData.Append($"{kv.Key}={kv.Value}&"); // Giá trị gốc cho chữ ký
                    }
                }

                string queryString = data.ToString().TrimEnd('&');
                string rawHashData = hashData.ToString().TrimEnd('&');
                string vnp_SecureHash = HmacSHA512(vnp_HashSecret, rawHashData);

                LogError($"Raw Hash Data: {rawHashData}", "CreateRequestUrl");
                LogError($"Generated Signature: {vnp_SecureHash}", "CreateRequestUrl");

                return $"{baseUrl}?{queryString}&vnp_SecureHash={vnp_SecureHash}";
            }

            private string HmacSHA512(string key, string inputData)
            {
                using (var hash = new System.Security.Cryptography.HMACSHA512(Encoding.UTF8.GetBytes(key)))
                {
                    var hashBytes = hash.ComputeHash(Encoding.UTF8.GetBytes(inputData));
                    return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                }
            }

            private void LogError(string message, string source)
            {
                try
                {
                    using (SqlConnection logCon = new SqlConnection(KN.GetConnectionString()))
                    {
                        logCon.Open();
                        using (SqlCommand logCmd = new SqlCommand("INSERT INTO ErrorLog (ErrorMessage, Source, ErrorDate) VALUES (@Message, @Source, @Date)", logCon))
                        {
                            logCmd.Parameters.AddWithValue("@Message", message);
                            logCmd.Parameters.AddWithValue("@Source", source);
                            logCmd.Parameters.AddWithValue("@Date", DateTime.Now);
                            logCmd.ExecuteNonQuery();
                        }
                    }
                }
                catch
                {
                }
            }
        }

        private void LogError(string message, string source)
        {
            try
            {
                using (SqlConnection logCon = new SqlConnection(KN.GetConnectionString()))
                {
                    logCon.Open();
                    using (SqlCommand logCmd = new SqlCommand("INSERT INTO ErrorLog (ErrorMessage, Source, ErrorDate) VALUES (@Message, @Source, @Date)", logCon))
                    {
                        logCmd.Parameters.AddWithValue("@Message", message);
                        logCmd.Parameters.AddWithValue("@Source", source);
                        logCmd.Parameters.AddWithValue("@Date", DateTime.Now);
                        logCmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
            }
        }
    }

    public class VnPayLibrary
    {
        private SortedList<string, string> _requestData = new SortedList<string, string>(new VnPayCompare());

        public void AddRequestData(string key, string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                _requestData.Add(key, value);
            }
        }

        public string CreateRequestUrl(string baseUrl, string vnp_HashSecret)
        {
            StringBuilder data = new StringBuilder();
            foreach (var kv in _requestData)
            {
                if (!string.IsNullOrEmpty(kv.Value))
                {
                    data.Append($"{kv.Key}={Uri.EscapeDataString(kv.Value)}&");
                }
            }

            string queryString = data.ToString().TrimEnd('&');
            string vnp_SecureHash = HmacSHA512(vnp_HashSecret, queryString);
            return $"{baseUrl}?{queryString}&vnp_SecureHash={vnp_SecureHash}";
        }

        private string HmacSHA512(string key, string inputData)
        {
            using (var hash = new System.Security.Cryptography.HMACSHA512(Encoding.UTF8.GetBytes(key)))
            {
                var hashBytes = hash.ComputeHash(Encoding.UTF8.GetBytes(inputData));
                return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }
        }
    }

    public class VnPayCompare : IComparer<string>
    {
        public int Compare(string x, string y)
        {
            return string.Compare(x, y);
        }
    }
}


