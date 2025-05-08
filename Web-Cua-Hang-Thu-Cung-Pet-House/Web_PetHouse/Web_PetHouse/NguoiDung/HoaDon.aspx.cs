using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
namespace Web_PetHouse.NguoiDung
{
	public partial class HoaDon : System.Web.UI.Page
	{
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MaNguoiDung"] == null)
                {
                    Response.Redirect("DangNhap.aspx");
                }
                else if (Request.QueryString["id"] != null)
                {
                    rOrderItem.DataSource = GetOrderDetails();
                    rOrderItem.DataBind();
                }
                else
                {
                    ShowErrorAlert("Không tìm thấy hóa đơn!");
                }
            }
        }

        DataTable GetOrderDetails()
        {
            double grandTotal = 0;
            con = new SqlConnection(KN.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "INVOICBYID");
            int paymentId = Convert.ToInt32(Request.QueryString["id"]);
            var userId = Session["MaNguoiDung"];
            cmd.Parameters.AddWithValue("@PaymentId", paymentId);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                ShowErrorAlert("Không tìm thấy hóa đơn!");
                dt = CreateEmptyTable();
            }
            else
            {
                foreach (DataRow drow in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(drow["TotalPrice"]);
                }
                DataRow dr = dt.NewRow();
                dr["SrNo"] = dt.Rows.Count + 1;
                dr["MaDonHang"] = "";
                dr["TenSanPham"] = "Tổng cộng";
                dr["Gia"] = DBNull.Value;
                dr["SoLuong"] = DBNull.Value;
                dr["TotalPrice"] = grandTotal;
                dt.Rows.Add(dr);
            }
            return dt;
        }

        DataTable CreateEmptyTable()
        {
            dt = new DataTable();
            dt.Columns.Add("SrNo", typeof(long));
            dt.Columns.Add("MaDonHang", typeof(string));
            dt.Columns.Add("TenSanPham", typeof(string));
            dt.Columns.Add("Gia", typeof(double));
            dt.Columns.Add("SoLuong", typeof(int));
            dt.Columns.Add("TotalPrice", typeof(double));
            DataRow dr = dt.NewRow();
            dr["SrNo"] = 1;
            dr["MaDonHang"] = "";
            dr["TenSanPham"] = "Không có đơn hàng";
            dr["Gia"] = DBNull.Value;
            dr["SoLuong"] = DBNull.Value;
            dr["TotalPrice"] = 0;
            dt.Rows.Add(dr);
            return dt;
        }

        protected void lbDownloadInvoice_Click(object sender, EventArgs e)
        {
            try
            {
                string downloadPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile), "Downloads", "hoadon.pdf");
                DataTable dtbl = GetOrderDetails();
                ExportToPdf(dtbl, downloadPath, "HÓA ĐƠN ");

                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=hoadon.pdf");
                Response.TransmitFile(downloadPath);
                Response.Flush();

               
            }
            catch (Exception ex)
            {
                ShowErrorAlert("Lỗi khi tải hóa đơn: " + ex.Message);
            }
        }

        void ShowSuccessAlert(string message)
        {
            string script = $@"
                Swal.fire({{
                    title: 'Thành công!',
                    html: '{message}',
                    icon: 'success',
                  
                    }},
                    didOpen: () => {{
                        document.getElementById('successSound').play();
                        confetti({{
                            particleCount: 150,
                            spread: 90,
                            colors: ['#ff6f61', '#ff0000', '#ffca28', '#ffffff'],
                            origin: {{ y: 0.6 }}
                        }});
                    }}
                }});
            ";
            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert", script, true);
        }

        void ShowErrorAlert(string message)
        {
            string script = $@"
                Swal.fire({{
                    title: 'Lỗi!',
                    html: '{message}',
                    icon: 'error',
                   
                    }},
                    didOpen: () => {{
                        document.getElementById('errorSound').play();
                    }}
                }});
            ";
            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", script, true);
        }
        void ExportToPdf(DataTable dtblTable, string strPdfPath, string strHeader)
        {
            try
            {
                using (FileStream fs = new FileStream(strPdfPath, FileMode.Create, FileAccess.Write, FileShare.None))
                using (Document document = new Document(PageSize.A4))
                {
                    PdfWriter writer = PdfWriter.GetInstance(document, fs);
                    document.Open();

                    string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "Arial.ttf");
                    BaseFont bfVietnamese = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                    iTextSharp.text.Font fontTitle = new iTextSharp.text.Font(bfVietnamese, 20, iTextSharp.text.Font.BOLD, new BaseColor(33, 150, 243)); // xanh dương
                    iTextSharp.text.Font fontHeader = new iTextSharp.text.Font(bfVietnamese, 12, iTextSharp.text.Font.BOLD, BaseColor.WHITE);
                    iTextSharp.text.Font fontCell = new iTextSharp.text.Font(bfVietnamese, 11, iTextSharp.text.Font.NORMAL, BaseColor.BLACK);

                    Paragraph title = new Paragraph(strHeader.ToUpper(), fontTitle)
                    {
                        Alignment = Element.ALIGN_CENTER
                    };
                    document.Add(title);

                    iTextSharp.text.Font fontSmall = new iTextSharp.text.Font(bfVietnamese, 10, iTextSharp.text.Font.ITALIC, BaseColor.GRAY);
                    Paragraph info = new Paragraph
                    {
                        Alignment = Element.ALIGN_RIGHT
                    };
                    info.Add(new Chunk("Hóa Đơn Mua Hàng PetHouse\n", fontSmall));
                    info.Add(new Chunk("Ngày: " + DateTime.Now.ToString("dd/MM/yyyy"), fontSmall));
                    document.Add(info);

                    document.Add(new Paragraph("\n"));

                    // Bảng
                    PdfPTable table = new PdfPTable(6) { WidthPercentage = 100 };
                    string[] headers = { "STT", "Mã Đơn Hàng", "Tên Sản Phẩm", "Giá", "Số Lượng", "Tổng Tiền" };

                    foreach (var h in headers)
                    {
                        PdfPCell cell = new PdfPCell(new Phrase(h, fontHeader))
                        {
                            BackgroundColor = new BaseColor(33, 150, 243),
                            HorizontalAlignment = Element.ALIGN_CENTER,
                            Padding = 5
                        };
                        table.AddCell(cell);
                    }

                    double grandTotal = 0;
                    foreach (DataRow row in dtblTable.Rows)
                    {
                        table.AddCell(new Phrase(row["SrNo"].ToString(), fontCell));
                        table.AddCell(new Phrase(row["MaDonHang"].ToString(), fontCell));
                        table.AddCell(new Phrase(row["TenSanPham"].ToString(), fontCell));

                        string gia = row["Gia"] != DBNull.Value ? string.Format("{0:N0} VND", row["Gia"]) : "";
                        string soLuong = row["SoLuong"] != DBNull.Value ? row["SoLuong"].ToString() : "";
                        string tongTien = row["TotalPrice"] != DBNull.Value ? string.Format("{0:N0} VND", row["TotalPrice"]) : "";

                        table.AddCell(new Phrase(gia, fontCell));
                        table.AddCell(new Phrase(soLuong, fontCell));
                        table.AddCell(new Phrase(tongTien, fontCell));

                        if (double.TryParse(row["TotalPrice"]?.ToString(), out double tien))
                        {
                            grandTotal += tien;
                        }
                    }

                    // Tổng cộng
                    PdfPCell totalLabel = new PdfPCell(new Phrase("Tổng cộng", fontHeader))
                    {
                        Colspan = 5,
                        BackgroundColor = new BaseColor(200, 230, 201), 
                        HorizontalAlignment = Element.ALIGN_RIGHT,
                        Padding = 5
                    };
                    table.AddCell(totalLabel);

                    PdfPCell totalValue = new PdfPCell(new Phrase(string.Format("{0:N0} VND", grandTotal), fontCell))
                    {
                        HorizontalAlignment = Element.ALIGN_LEFT,
                        Padding = 5
                    };
                    table.AddCell(totalValue);

                    document.Add(table);
                    document.Close();
                    writer.Close();
                }
            }
            catch (Exception ex)
            {
                ShowErrorAlert("Lỗi khi tạo file PDF: " + ex.Message);
            }
        }



    }
}