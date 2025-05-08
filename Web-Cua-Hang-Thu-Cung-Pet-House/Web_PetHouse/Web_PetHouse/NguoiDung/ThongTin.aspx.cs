using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
    public partial class ThongTin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MaNguoiDung"] == null)
                {
                    Response.Redirect("DangNhap.aspx");
                }
                else
                {
                    getUserDetails();
                    getPurchaseHistory();

                    if (Request.QueryString["updated"] == "true")
                    {
                        Response.Redirect("TrangChu.aspx");
                    }
                }
            }
        }

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        void getUserDetails()
        {
            try
            {
                con = new SqlConnection(KN.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECTPROFILE");
                cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rUserProfile.DataSource = dt;
                    rUserProfile.DataBind();

                    Session["HoTen"] = dt.Rows[0]["HoTen"].ToString();
                    Session["Email"] = dt.Rows[0]["Email"].ToString();
                    Session["HinhAnh"] = dt.Rows[0]["HinhAnh"].ToString();
                    Session["NgayTao"] = dt.Rows[0]["NgayTao"].ToString();
                }
            }
            catch (Exception ex)
            {
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi tải thông tin người dùng: <b>{ex.Message}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }

        void getPurchaseHistory()
        {
            try
            {
                int sr = 1;
                con = new SqlConnection(KN.GetConnectionString());
                cmd = new SqlCommand("Invoice", con);
                cmd.Parameters.AddWithValue("@Action", "ODRHISTORY");
                cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (!dt.Columns.Contains("MaThanhToan"))
                {
                    throw new Exception("Stored procedure 'Invoice' với hành động 'ODRHISTORY' không trả về cột MaThanhToan.");
                }

                dt.Columns.Add("SrNo", typeof(Int32));
                foreach (DataRow dataRow in dt.Rows)
                {
                    dataRow["SrNo"] = sr;
                    sr++;
                }

                if (dt.Rows.Count == 0)
                {
                    rPurchaseHistory.FooterTemplate = null;
                    rPurchaseHistory.FooterTemplate = new CustomTemplate(ListItemType.Footer);
                }

                rPurchaseHistory.DataSource = dt;
                rPurchaseHistory.DataBind();
            }
            catch (Exception ex)
            {
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi tải lịch sử mua hàng: <b>{ex.Message}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }

        protected void rPurchaseHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    HiddenField paymentId = e.Item.FindControl("hdnPaymentId") as HiddenField;
                    Repeater repOrders = e.Item.FindControl("rOrders") as Repeater;

                    if (paymentId != null && !string.IsNullOrEmpty(paymentId.Value))
                    {
                        con = new SqlConnection(KN.GetConnectionString());
                        cmd = new SqlCommand("Invoice", con);
                        cmd.Parameters.AddWithValue("@Action", "INVOICBYID");
                        cmd.Parameters.AddWithValue("@PaymentId", Convert.ToInt32(paymentId.Value));
                        cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                        cmd.CommandType = CommandType.StoredProcedure;
                        sda = new SqlDataAdapter(cmd);
                        dt = new DataTable();
                        sda.Fill(dt);

                        repOrders.DataSource = dt;
                        repOrders.DataBind();
                    }
                    else
                    {
                        repOrders.DataSource = null;
                        repOrders.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    string errorScript = $@"
                        Swal.fire({{
                            title: 'Lỗi!',
                            html: 'Có lỗi xảy ra khi tải chi tiết đơn hàng: <b>{ex.Message}</b>',
                            icon: 'error'
                        }});
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
                }
            }
        }

        private sealed class CustomTemplate : ITemplate
        {
            private ListItemType ListItemType { get; set; }

            public CustomTemplate(ListItemType type)
            {
                ListItemType = type;
            }

            public void InstantiateIn(Control container)
            {
                if (ListItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<tr><td colspan='5'><b> Ủng hộ đi bạn" +
                        ".</b><a href='CuaHang.aspx' class='badge badge-info ml-2'>Ấn để đặt hàng!!!</a></td></tr></tbody></table>");
                    container.Controls.Add(footer);
                }
            }
        }
    }
}