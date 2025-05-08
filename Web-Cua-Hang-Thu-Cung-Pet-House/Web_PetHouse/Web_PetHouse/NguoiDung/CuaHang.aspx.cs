using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
    public partial class CuaHang : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        int pageSize = 6;
        int currentPage = 1;
        int totalRecords = 0;
        int totalPages = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["PageSize"] != null)
                {
                    pageSize = Convert.ToInt32(Session["PageSize"]);
                    ddlShow.SelectedValue = pageSize.ToString();
                }

                if (Request.QueryString["page"] != null)
                {
                    currentPage = Convert.ToInt32(Request.QueryString["page"]);
                }

                getCategories();
                getProducts(); 
            }
        }

        protected void rCategory_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "LoadProductsByCategory")
            {
                int categoryId = Convert.ToInt32(e.CommandArgument);
                Session["CategoryId"] = categoryId;
                currentPage = 1;
                getProducts(categoryId: (int)Session["CategoryId"]);
            }
        }

        private void getCategories()
        {
            using (con = new SqlConnection(KN.GetConnectionString()))
            {
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                rCategory.DataSource = dt;
                rCategory.DataBind();
            }
        }

        private void getProducts(string searchText = "", string sortOrder = "", int? categoryId = null, decimal? minPrice = null, decimal? maxPrice = null)
        {
            try
            {
                if (!categoryId.HasValue && Session["CategoryId"] != null)
                {
                    categoryId = Convert.ToInt32(Session["CategoryId"]);
                }

                using (con = new SqlConnection(KN.GetConnectionString()))
                {
                    cmd = new SqlCommand("SanPham_Crud", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HanhDong", "GETALL");
                    cmd.Parameters.AddWithValue("@MaDanhMuc", categoryId.HasValue ? (object)categoryId.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@MaDanhMucCon", DBNull.Value); // Không dùng danh mục con
                    cmd.Parameters.AddWithValue("@MinPrice", minPrice.HasValue ? (object)minPrice.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@MaxPrice", maxPrice.HasValue ? (object)maxPrice.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Sort", string.IsNullOrEmpty(sortOrder) ? DBNull.Value : (object)sortOrder);

                    sda = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    sda.Fill(dt);

                    totalRecords = dt.Rows.Count;
                    totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
                    if (currentPage < 1) currentPage = 1;
                    if (currentPage > totalPages) currentPage = totalPages;

                    if (!string.IsNullOrEmpty(searchText))
                    {
                        var filteredRows = dt.AsEnumerable()
                            .Where(row => row.Field<string>("TenSanPham")
                            .IndexOf(searchText, StringComparison.OrdinalIgnoreCase) >= 0);

                        if (filteredRows.Any())
                        {
                            dt = filteredRows.CopyToDataTable();
                        }
                        else
                        {
                            dt = dt.Clone();
                        }
                    }

                    DataTable pagedDt;
                    if (dt.Rows.Count > 0)
                    {
                        pagedDt = dt.AsEnumerable()
                            .Skip((currentPage - 1) * pageSize)
                            .Take(pageSize)
                            .CopyToDataTable();
                    }
                    else
                    {
                        pagedDt = dt.Clone();
                    }

                    rProducts.DataSource = pagedDt;
                    rProducts.DataBind();

                    lblPageInfo.Text = $"{currentPage} of {totalPages}";
                    btnPrevPage.Enabled = currentPage > 1;
                    btnNextPage.Enabled = currentPage < totalPages;

                    if (totalRecords == 0 && categoryId.HasValue)
                    {
                        string script = @"
                            Swal.fire({
                                title: 'Thông báo',
                                html: 'Không có sản phẩm nào thuộc danh mục này!',
                                icon: 'info'
                            });
                        ";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "NoProductsAlert", script, true);
                    }
                }
            }
            catch (Exception ex)
            {
                string errorScript = $@"
                    Swal.fire({{
                        title: 'Lỗi!',
                        html: 'Có lỗi xảy ra khi tải sản phẩm: <b>{ex.Message}</b>',
                        icon: 'error'
                    }});
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
            }
        }

        protected void rCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlSort.SelectedIndex = 0;
            txtMinPrice.Text = "0";
            txtMaxPrice.Text = "10000000";
            Session.Remove("CategoryId");
            Session.Remove("MinPrice");
            Session.Remove("MaxPrice");
            Session.Remove("Sort");
            currentPage = 1;
            getProducts();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            string sortOrder = ddlSort.SelectedValue;
            int? categoryId = Session["CategoryId"] != null ? (int?)Convert.ToInt32(Session["CategoryId"]) : null;
            decimal? minPrice = Session["MinPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MinPrice"]) : null;
            decimal? maxPrice = Session["MaxPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MaxPrice"]) : null;
            getProducts("", sortOrder, categoryId, minPrice, maxPrice);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();
            string sortOrder = ddlSort.SelectedValue;
            int? categoryId = Session["CategoryId"] != null ? (int?)Convert.ToInt32(Session["CategoryId"]) : null;
            decimal? minPrice = Session["MinPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MinPrice"]) : null;
            decimal? maxPrice = Session["MaxPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MaxPrice"]) : null;
            getProducts(searchText, sortOrder, categoryId, minPrice, maxPrice);
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();
            string sortOrder = ddlSort.SelectedValue;
            Session["Sort"] = sortOrder;
            int? categoryId = Session["CategoryId"] != null ? (int?)Convert.ToInt32(Session["CategoryId"]) : null;
            decimal? minPrice = Session["MinPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MinPrice"]) : null;
            decimal? maxPrice = Session["MaxPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MaxPrice"]) : null;
            getProducts(searchText, sortOrder, categoryId, minPrice, maxPrice);
        }

        protected void ddlShow_SelectedIndexChanged(object sender, EventArgs e)
        {
            pageSize = Convert.ToInt32(ddlShow.SelectedValue);
            Session["PageSize"] = pageSize;
            currentPage = 1;
            string searchText = txtSearch.Text.Trim();
            string sortOrder = ddlSort.SelectedValue;
            int? categoryId = Session["CategoryId"] != null ? (int?)Convert.ToInt32(Session["CategoryId"]) : null;
            decimal? minPrice = Session["MinPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MinPrice"]) : null;
            decimal? maxPrice = Session["MaxPrice"] != null ? (decimal?)Convert.ToDecimal(Session["MaxPrice"]) : null;
            getProducts(searchText, sortOrder, categoryId, minPrice, maxPrice);
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            currentPage--;
            string queryString = BuildQueryString();
            Response.Redirect($"CuaHang.aspx?{queryString}");
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            currentPage++;
            string queryString = BuildQueryString();
            Response.Redirect($"CuaHang.aspx?{queryString}");
        }

        private string BuildQueryString()
        {
            string query = $"page={currentPage}";
            if (Session["CategoryId"] != null)
            {
                query += $"&category={Session["CategoryId"]}";
            }
            return query;
        }

        protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "addToCart")
            {
                if (Session["MaNguoiDung"] != null)
                {
                    int userId = Convert.ToInt32(Session["MaNguoiDung"]);
                    int productId = Convert.ToInt32(e.CommandArgument);
                    int existingQuantity = isItemExistInCart(productId, userId);

                    if (existingQuantity == 0)
                    {
                        using (con = new SqlConnection(KN.GetConnectionString()))
                        {
                            cmd = new SqlCommand("Cart_Crud", con);
                            cmd.Parameters.AddWithValue("@Action", "INSERT");
                            cmd.Parameters.AddWithValue("@ProductId", productId);
                            cmd.Parameters.AddWithValue("@Quantity", 1);
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.CommandType = CommandType.StoredProcedure;

                            try
                            {
                                con.Open();
                                cmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                string errorScript = $@"
                                    Swal.fire({{
                                        title: 'Lỗi!',
                                        html: 'Có lỗi xảy ra: <b>{ex.Message}</b>',
                                        icon: 'error'
                                    }});
                                ";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
                                return;
                            }
                        }
                    }
                    else
                    {
                        KetNoi utils = new KetNoi();
                        utils.updateCartQuantity(existingQuantity + 1, productId, userId);
                    }

                    string successScript = @"
                        Swal.fire({
                            title: 'Thành công!',
                            html: 'Sản phẩm đã được thêm vào giỏ hàng!',
                            icon: 'success'
                        }).then(() => { window.location.href = 'GioHang.aspx'; });
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert", successScript, true);
                }
                else
                {
                    string errorScript = @"
                        Swal.fire({
                            title: 'Lỗi!',
                            html: 'Vui lòng đăng nhập để mua hàng!',
                            icon: 'info'
                        }).then(() => { window.location.href = 'DangNhap.aspx'; });
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert", errorScript, true);
                }
            }
        }

        protected void btnAllProducts_Click(object sender, EventArgs e)
        {
            Session.Remove("CategoryId");
            currentPage = 1;
            getProducts();
        }

        private int isItemExistInCart(int productId, int userId)
        {
            using (con = new SqlConnection(KN.GetConnectionString()))
            {
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.CommandType = CommandType.StoredProcedure;

                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    return Convert.ToInt32(dt.Rows[0]["SoLuong"]);
                }
                return 0;
            }
        }

        protected void btnFilterPrice_Click(object sender, EventArgs e)
        {
            decimal minPrice;
            decimal maxPrice;

            if (!decimal.TryParse(txtMinPrice.Text, out minPrice))
            {
                minPrice = 0;
            }
            if (!decimal.TryParse(txtMaxPrice.Text, out maxPrice))
            {
                maxPrice = 10000000;
            }

            if (minPrice > maxPrice)
            {
                decimal temp = minPrice;
                minPrice = maxPrice;
                maxPrice = temp;
                txtMinPrice.Text = minPrice.ToString();
                txtMaxPrice.Text = maxPrice.ToString();
            }

            Session["MinPrice"] = minPrice;
            Session["MaxPrice"] = maxPrice;
            currentPage = 1;
            string searchText = txtSearch.Text.Trim();
            string sortOrder = ddlSort.SelectedValue;
            int? categoryId = Session["CategoryId"] != null ? (int?)Convert.ToInt32(Session["CategoryId"]) : null;
            getProducts(searchText, sortOrder, categoryId, minPrice, maxPrice);
        }
    }
}