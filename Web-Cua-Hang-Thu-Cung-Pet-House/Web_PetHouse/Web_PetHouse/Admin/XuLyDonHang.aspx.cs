using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Web_PetHouse.Admin
{
    public partial class XuLyDonHang : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCrumbTitle"] = "Quản lý đơn hàng";
            Session["breadCrumbPage"] = "Đơn hàng";
            if (!IsPostBack)
            {
                getOrderStatus(); 
            }
            pUpdateOrderStatus.Visible = false;
        }

        protected void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "message-label text-success" : "message-label text-danger";
            lblMsg.Style["display"] = "block";
            string script = "setTimeout(function() { " +
                            "var lblMsg = document.getElementById('" + lblMsg.ClientID + "'); " +
                            "if (lblMsg) lblMsg.style.display = 'none'; " +
                            "}, 5000);";
            ScriptManager.RegisterStartupScript(this, GetType(), "HideMessage", script, true);
        }
        void getOrderStatus()
        {
            con = new SqlConnection(KetNoi.getConnection());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "GETSTATUS");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rOrderStatus.DataSource = dt;
            rOrderStatus.DataBind();
        }
        protected void rOrderStatus_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Style["display"] = "none";
            if (e.CommandName == "edit")
            {
                try
                {
                    ShowMessage("Đã chọn đơn hàng = " + e.CommandArgument.ToString(), true); 
                    con = new SqlConnection(KetNoi.getConnection());
                    con.Open();
                    cmd = new SqlCommand("Invoice", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "STATUSBYID");
                    cmd.Parameters.Add("@OrderDetailsId", SqlDbType.NVarChar).Value = e.CommandArgument.ToString();
                    sda = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        string trangThai = dt.Rows[0]["TrangThai"].ToString().Trim();
                        switch (trangThai)
                        {
                            case "Pending":
                            case "Processing":
                            case "Chờ xử lý":
                                trangThai = "Đang xử lý";
                                break;
                            case "Shipped":
                            case "Đã gửi hàng":
                                trangThai = "Đã gửi";
                                break;
                            case "Delivered":
                            case "Đã giao hàng":
                                trangThai = "Đã giao";
                                break;
                            default:
                                trangThai = "0";
                                break;
                        }
                        ddlOrderStatus.SelectedValue = trangThai;
                        hdnId.Value = dt.Rows[0]["MaDonHang"].ToString();
                        pUpdateOrderStatus.Visible = true;
                    }
                    else
                    {
                        ShowMessage("Không tìm thấy đơn hàng với mã này.", false);
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi: " + ex.Message, false);
                }
                finally
                {
                    if (con != null && con.State == ConnectionState.Open)
                        con.Close();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlOrderStatus.SelectedValue == "0")
                {
                    ShowMessage("Vui lòng chọn một trạng thái hợp lệ.", false);
                    return; 
                }

                string selectedStatus = ddlOrderStatus.SelectedValue.Trim().Normalize(NormalizationForm.FormC);
                con = new SqlConnection(KetNoi.getConnection());
                con.Open();
                cmd = new SqlCommand("Invoice", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "UPDTSTATUS");
                cmd.Parameters.Add("@OrderDetailsId", SqlDbType.NVarChar).Value = hdnId.Value.Trim();
                cmd.Parameters.AddWithValue("@Status", selectedStatus);

                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    ShowMessage("Cập nhật trạng thái đơn hàng thành công.", true);
                    getOrderStatus();
                    pUpdateOrderStatus.Visible = false;
                }
               
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi khi cập nhật trạng thái: " + ex.Message, false);
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pUpdateOrderStatus.Visible = false;
        }
    }
}