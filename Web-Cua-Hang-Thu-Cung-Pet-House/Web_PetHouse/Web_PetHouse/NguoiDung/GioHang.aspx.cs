using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        decimal grandTotal = 0;

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
                    UpdateCartCount(Convert.ToInt32(Session["MaNguoiDung"])); // Cập nhật cartCount khi tải trang
                    getCartItems();
                }
            }
        }

        void getCartItems()
        {
            try
            {
                con = new SqlConnection(KN.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                rCartItem.DataSource = dt;
                if (dt.Rows.Count == 0)
                {
                    rCartItem.FooterTemplate = null;
                    rCartItem.FooterTemplate = new CustomTemplate(ListItemType.Footer);
                }
                rCartItem.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Lỗi khi tải giỏ hàng: {ex.Message}');", true);
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
                    var footer = new LiteralControl("<tr><td colspan='6' class='text-center'><b style='color: #ff0000;'>Giỏ hàng trống </b><a href='CuaHang.aspx' class='btn ml-2'><i class='fa fa-arrow-circle-right mr-2'></i>");
                    container.Controls.Add(footer);
                }
            }
        }

        protected void rCartItem_ItemCommand1(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "remove")
            {
                try
                {
                    con = new SqlConnection(KN.GetConnectionString());
                    cmd = new SqlCommand("Cart_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    int userId = Convert.ToInt32(Session["MaNguoiDung"]);
                    UpdateCartCount(userId); // Cập nhật cartCount sau khi xóa
                    getCartItems();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showSuccessAlert('Đã xóa khỏi giỏ hàng!');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Lỗi khi xóa sản phẩm: {ex.Message}');", true);
                }
            }
        }

        protected void lbUpdateCart_Click(object sender, EventArgs e)
        {
            try
            {
                bool isCartUpdated = false;
                con = new SqlConnection(KN.GetConnectionString());

                foreach (RepeaterItem item in rCartItem.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = item.FindControl("txtQuantity") as TextBox;
                        HiddenField hdnProductId = item.FindControl("hdnProductId") as HiddenField;
                        HiddenField hdnPrdQuantity = item.FindControl("hdnPrdQuantity") as HiddenField;

                        if (quantity != null && hdnProductId != null && hdnPrdQuantity != null)
                        {
                            int quantityFromCart = Convert.ToInt32(quantity.Text);
                            int productId = Convert.ToInt32(hdnProductId.Value);
                            int productQuantity = Convert.ToInt32(hdnPrdQuantity.Value);

                            if (quantityFromCart <= 0)
                            {
                                throw new Exception($"Số lượng của sản phẩm không hợp lệ (phải lớn hơn 0).");
                            }

                            if (quantityFromCart > productQuantity)
                            {
                                throw new Exception($"Số lượng yêu cầu ({quantityFromCart}) vượt quá số lượng tồn kho ({productQuantity}) của sản phẩm.");
                            }

                            cmd = new SqlCommand("Cart_Crud", con);
                            cmd.Parameters.AddWithValue("@Action", "UPDATE");
                            cmd.Parameters.AddWithValue("@UserId", Session["MaNguoiDung"]);
                            cmd.Parameters.AddWithValue("@ProductId", productId);
                            cmd.Parameters.AddWithValue("@Quantity", quantityFromCart);
                            cmd.CommandType = CommandType.StoredProcedure;

                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();

                            isCartUpdated = true;
                        }
                    }
                }

                int userId = Convert.ToInt32(Session["MaNguoiDung"]);
                UpdateCartCount(userId); // Cập nhật cartCount sau khi cập nhật giỏ hàng
                getCartItems();
                if (isCartUpdated)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showSuccessAlert('Cập nhật giỏ hàng thành công!');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Lỗi khi cập nhật giỏ hàng: {ex.Message}');", true);
            }
        }

        protected void lbCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                bool isInStock = true;
                string outOfStockProduct = string.Empty;

                foreach (RepeaterItem item in rCartItem.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = item.FindControl("txtQuantity") as TextBox;
                        HiddenField hdnPrdQuantity = item.FindControl("hdnPrdQuantity") as HiddenField;
                        Label productName = item.FindControl("lblName") as Label;

                        if (quantity != null && hdnPrdQuantity != null && productName != null)
                        {
                            int cartQuantity = Convert.ToInt32(quantity.Text);
                            int productQuantity = Convert.ToInt32(hdnPrdQuantity.Value);

                            if (cartQuantity <= 0)
                            {
                                throw new Exception($"Số lượng của sản phẩm '{productName.Text}' không hợp lệ (phải lớn hơn 0).");
                            }

                            if (productQuantity < cartQuantity || productQuantity == 0)
                            {
                                isInStock = false;
                                outOfStockProduct = productName.Text;
                                break;
                            }
                        }
                    }
                }

                if (isInStock)
                {
                    Response.Redirect("ThanhToan.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Sản phẩm \\'{outOfStockProduct}\\' không đủ hàng hoặc đã hết hàng!');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Lỗi khi thanh toán: {ex.Message}');", true);
            }
        }

        protected void rCartItem_ItemDataBound1(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label totalPrice = e.Item.FindControl("lblTotalPrice") as Label;
                Label productPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox quantity = e.Item.FindControl("txtQuantity") as TextBox;

                if (totalPrice != null && productPrice != null && quantity != null)
                {
                    decimal price = Convert.ToDecimal(productPrice.Text);
                    int qty = Convert.ToInt32(quantity.Text);
                    decimal calTotalPrice = price * qty;
                    totalPrice.Text = calTotalPrice.ToString("N0") + " VNĐ";
                    grandTotal += calTotalPrice;
                }
            }
            Session["grandTotalPrice"] = grandTotal.ToString("N0") + " VNĐ";
        }

        void UpdateCartCount(int userId)
        {
            try
            {
                con = new SqlConnection(KN.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GET_CART_COUNT");
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                int cartCount = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();

                Session["cartCount"] = cartCount;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"showErrorAlert('Lỗi khi cập nhật số lượng giỏ hàng: {ex.Message}');", true);
            }
        }
    }
}