using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
    public partial class VNPayReturn : System.Web.UI.Page
    {
        private readonly string vnp_HashSecret = "TS1LG8D8VAIWV4P9B0L4EYRV1AK27JTH";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProcessVNPayResponse();
            }
        }
        private void ProcessVNPayResponse()
        {
            try
            {
                // Lấy tất cả tham số từ query string
                var vnpayData = Request.QueryString.AllKeys.ToDictionary(k => k, k => Request.QueryString[k]);
                string vnp_TxnRef = vnpayData.ContainsKey("vnp_TxnRef") ? vnpayData["vnp_TxnRef"] : "";
                string vnp_ResponseCode = vnpayData.ContainsKey("vnp_ResponseCode") ? vnpayData["vnp_ResponseCode"] : "";
                string vnp_SecureHash = vnpayData.ContainsKey("vnp_SecureHash") ? vnpayData["vnp_SecureHash"] : "";
                string vnp_PaymentId = vnpayData.ContainsKey("vnp_PaymentId") ? vnpayData["vnp_PaymentId"] : "";

                // Log tất cả tham số nhận được
                string paramLog = string.Join(", ", vnpayData.Select(kvp => $"{kvp.Key}={kvp.Value}"));
                LogError($"VNPay Response Params: {paramLog}", "ProcessVNPayResponse");

                // Tạo chuỗi dữ liệu để kiểm tra chữ ký (sử dụng giá trị gốc, giải mã URL)
                string signData = string.Join("&", vnpayData
                    .Where(kvp => !string.IsNullOrEmpty(kvp.Value) && kvp.Key != "vnp_SecureHash")
                    .OrderBy(kvp => kvp.Key)
                    .Select(kvp => $"{kvp.Key}={HttpUtility.UrlDecode(kvp.Value)}"));

                LogError($"Sign Data: {signData}", "ProcessVNPayResponse");

                // Tạo chữ ký để so sánh
                string checkSum = HmacSHA512(vnp_HashSecret, signData);
                LogError($"Generated Checksum: {checkSum}, Received Signature: {vnp_SecureHash}", "ProcessVNPayResponse");

                if (checkSum.Equals(vnp_SecureHash, StringComparison.InvariantCultureIgnoreCase))
                {
                    if (vnp_ResponseCode == "00")
                    {
                        // Giao dịch thành công, cập nhật trạng thái đơn hàng
                        UpdateOrderStatus(vnp_TxnRef, vnp_PaymentId);
                        lblResult.Text = "Thanh toán VNPay thành công! Đơn hàng của bạn đã được xử lý.";
                        ScriptManager.RegisterStartupScript(this, GetType(), "success", $"showSuccessAlert('Thanh toán VNPay thành công!', 'HoaDon.aspx?id={vnp_PaymentId}');", true);
                    }
                    else
                    {
                        lblResult.Text = $"Thanh toán VNPay thất bại. Mã lỗi: {vnp_ResponseCode}";
                        ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorAlert('Thanh toán VNPay thất bại. Mã lỗi: {vnp_ResponseCode}');", true);
                    }
                }
                else
                {
                    lblResult.Text = "Lỗi: Chữ ký không hợp lệ. Giao dịch không được xác thực.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", "showErrorAlert('Chữ ký không hợp lệ. Giao dịch không được xác thực.');", true);
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Lỗi xử lý phản hồi VNPay.";
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorAlert('Lỗi: {ex.Message}');", true);
                LogError(ex.Message, "ProcessVNPayResponse");
            }
        }

        private void UpdateOrderStatus(string vnp_TxnRef, string paymentId)
        {
            using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
            {
                try
                {
                    con.Open();
                    // Tìm MaDonHang dựa trên VnpTxnRef hoặc PaymentId
                    string maDonHang = null;
                    using (SqlCommand cmd = new SqlCommand("SELECT MaDonHang FROM DonHang WHERE MaThanhToan = @PaymentId", con))
                    {
                        cmd.Parameters.AddWithValue("@PaymentId", paymentId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                maDonHang = dr["MaDonHang"].ToString();
                            }
                        }
                    }

                    if (string.IsNullOrEmpty(maDonHang))
                    {
                        throw new Exception($"Không tìm thấy đơn hàng với PaymentId: {paymentId}");
                    }

                    // Cập nhật trạng thái đơn hàng
                    using (SqlCommand cmd = new SqlCommand("UPDATE DonHang SET TrangThai = @TrangThai WHERE MaDonHang = @OrderId", con))
                    {
                        cmd.Parameters.AddWithValue("@TrangThai", "Đã thanh toán");
                        cmd.Parameters.AddWithValue("@OrderId", maDonHang);
                        cmd.ExecuteNonQuery();
                    }

                    LogError($"Updated order status for MaDonHang: {maDonHang}", "UpdateOrderStatus");
                }
                catch (Exception ex)
                {
                    LogError($"Error updating order status: {ex.Message}", "UpdateOrderStatus");
                    throw new Exception($"Lỗi khi cập nhật trạng thái đơn hàng: {ex.Message}");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
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

        private string HmacSHA512(string key, string inputData)
        {
            var hash = new HMACSHA512(Encoding.UTF8.GetBytes(key));
            var hashBytes = hash.ComputeHash(Encoding.UTF8.GetBytes(inputData));
            return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThanhToan.aspx");
        }
    }
}