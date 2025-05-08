using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.Admin
{
    public partial class BangDieuKhien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrumbTitle"] = "Trang chủ";
                Session["breadCrumbPage"] = "Bảng điều khiển";

                LoadThongKe();
                LoadDuLieuDoanhThu();
            }
        }

        private void LoadThongKe()
        {
            using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
            {
                con.Open();

                lblTongDanhMuc.Text = GetCount("DanhMuc", con).ToString();
                lblTongSanPham.Text = GetCount("SanPham", con).ToString();
                lblTongNguoiDung.Text = GetCount("NguoiDung", con).ToString();
                lblTongDonHang.Text = GetCount("DonHang", con).ToString();

                con.Close();
            }
        }

        private int GetCount(string tableName, SqlConnection conn)
        {
            string query = $"SELECT COUNT(*) FROM {tableName}";
            SqlCommand cmd = new SqlCommand(query, conn);
            return (int)cmd.ExecuteScalar();
        }

        private void LoadDuLieuDoanhThu()
        {
            List<string> labels = new List<string>();
            List<int> values = new List<int>();

            using (SqlConnection con = new SqlConnection(KN.GetConnectionString()))
            {
                con.Open();
                string query = "SELECT p.HinhThucThanhToan, SUM(s.Gia * d.SoLuong) AS DoanhThu " +
                               "FROM DonHang d " +
                               "INNER JOIN SanPham s ON d.MaSanPham = s.MaSanPham " +
                               "INNER JOIN ThanhToan p ON d.MaThanhToan = p.MaThanhToan " +
                               "GROUP BY p.HinhThucThanhToan";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    labels.Add(reader["HinhThucThanhToan"].ToString());
                    values.Add(Convert.ToInt32(reader["DoanhThu"]));
                }

                con.Close();
            }

            // Lưu trữ các giá trị vào HiddenField (hdnLabels và hdnValues)
            hdnLabels.Value = string.Join(",", labels);
            hdnValues.Value = string.Join(",", values);
        }

    }
}

