<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="CuaHang.aspx.cs" Inherits="Web_PetHouse.NguoiDung.CuaHang" %>
<%@ Import Namespace="Web_PetHouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container-fluid.pt-5 {
            padding-top: 3rem !important;
        }

        .category-list {
            padding: 0;
            background: #fff;
        }

        .category-list .nav-item {
            border-bottom: 1px solid #e5e5e5;
        }

        .category-list .nav-link {
            display: flex;
            align-items: center;
            padding: 15px;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            transition: 0.3s;
        }

        .category-list .nav-link:hover {
            background: #f8f9fa;
            color: #1da1f2;
        }

        .category-list .menu-icon {
            width: 30px;
            height: 30px;
            margin-right: 10px;
        }

        .category-list .dropdown-menu {
            border: none;
            border-radius: 0;
            background: #f8f9fa;
            width: 100%;
            padding: 0;
        }

        .category-list .dropdown-item {
            padding: 10px 20px;
            font-size: 14px;
            color: #333;
            transition: 0.3s;
        }

        .category-list .dropdown-item:hover {
            background: #1da1f2;
            color: #fff;
        }

        .price-filter {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #e5e5e5;
            border-radius: 5px;
            background: #fff;
            display: block;
        }

        .price-filter h5 {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .price-range {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .price-range input[type="text"] {
            width: 100px;
            height: 38px;
            padding: 5px;
            font-size: 14px;
            background: #f8f9fa;
        }

        .range-slider {
            margin: 20px 0;
        }

        .range-slider input[type="range"] {
            width: 100%;
            -webkit-appearance: none;
            height: 5px;
            border-radius: 5px;
            background: #ddd;
            outline: none;
            opacity: 0.7;
            transition: opacity 0.2s;
        }

        .range-slider input[type="range"]:hover {
            opacity: 1;
        }

        
        .price-filter .btn-filter {
            width: 100%;
            background: #333;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
            transition: 0.3s;
        }

        .price-filter .btn-filter:hover {
            background: #1da1f2;
        }

        .search-filter-container {
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .search-filter-container .form-control,
        .search-filter-container .btn {
            font-size: 14px;
            height: 38px;
        }

        .search-filter-container .input-group {
            width: 100%;
        }

        .search-filter-container .btn {
            padding: 0 15px;
        }

        .search-filter-container .input-group-append {
            display: flex;
            gap: 5px;
        }

        .product-item {
            position: relative;
            transition: 0.3s;
        }

        .product-item:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product-img img {
            transition: 0.3s;
        }

        .product-img img:hover {
            transform: scale(1.05);
        }

        .product-item .badge {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 12px;
            padding: 5px 10px;
        }

        .product-item .badge.sale {
            background: #1da1f2;
            color: #fff;
        }

        .product-item .badge.new {
            background: #28a745;
            color: #fff;
        }

        .product-item .card-body {
            padding: 15px;
        }

        .product-item h6 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-item .price {
            display: flex;
            gap: 10px;
            align-items: center;
            justify-content: center;
        }

        .product-item .price h6 {
            font-size: 16px;
            color: #333;
        }

        .product-item .price del {
            font-size: 14px;
            color: #999;
        }

        .product-item a {
            color: #1da1f2 !important;
        }

     
.pagination-container {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 20px;
}

.page-info {
    font-size: 16px;
    color: #333;
    margin-right: 20px;
}

.pagination-buttons {
    display: flex;
    align-items: center;
}

.btn-prev, .btn-next {
    font-size: 16px;
    padding: 8px 15px;
    margin: 0 5px;
    border: 2px solid #007bff;
    background-color: #fff;
    color: #007bff;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s, color 0.3s;
}

.btn-prev:hover, .btn-next:hover {
    background-color: #007bff;
    color: #fff;
}

.btn-prev:disabled, .btn-next:disabled {
    background-color: #f0f0f0;
    color: #ccc;
    cursor: not-allowed;
}

.btn-prev, .btn-next {
    border: 2px solid #007bff;
}

    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        window.onload = function () {
            particlesJS('particles-js', {
                "particles": {
                    "number": { "value": 80, "density": { "enable": true, "value_area": 800 } },
                    "color": { "value": "#ffffff" },
                    "shape": { "type": "circle" },
                    "opacity": { "value": 0.5 },
                    "size": { "value": 3, "random": true },
                    "move": { "enable": true, "speed": 6 }
                },
                "interactivity": {
                    "detect_on": "canvas",
                    "events": { "onhover": { "enable": true, "mode": "repulse" } }
                }
            });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="particles-js" style="position: absolute; width: 100%; height: 100%;"></div>

    <!-- Page Header Start -->
    <div class="d-flex flex-column align-items-center justify-content-center text-center bg-secondary" style="min-height: 300px">
        <h1 class="font-weight-bold text-uppercase mb-3 title-effect">CỬA HÀNG</h1>
        <div class="d-inline-flex align-items-center breadcrumb-custom">
            <h2 class="m-0"><a href="TrangChu.aspx" class="text-decoration-none">TRANG CHỦ</a></h2>
            <span class="mx-2">|</span>
            <h2 class="m-0 text-muted">CỬA HÀNG</h2>
        </div>
    </div>

    <div class="container-fluid pt-5">
        <div class="row px-xl-5">
            <div class="col-lg-3 col-md-12 mb-4">
                <div class="category-list navbar-nav w-100 overflow-hidden">
                    <div class="nav-item">
                        <asp:LinkButton ID="btnAllProducts" runat="server" CssClass="nav-link" OnClick="btnAllProducts_Click">
                            <i class="fa fa-list-alt mr-4"></i>Tất cả
                        </asp:LinkButton>
                    </div>
<asp:Repeater ID="rCategory" runat="server" OnItemDataBound="rCategory_ItemDataBound">
    <ItemTemplate>
        <div class="nav-item">
            <asp:LinkButton ID="btnCategory" runat="server" CommandName="LoadProductsByCategory"
                CommandArgument='<%# Eval("MaDanhMuc") %>' CssClass="nav-link"
                OnCommand="rCategory_Command">
                <img src='<%# ResolveUrl("" + Eval("HinhAnhDanhMuc")) %>' 
                     alt='<%# Eval("TenDanhMuc") %>' 
                     style="width: 30px; height: 30px; object-fit: cover; margin-right: 8px;"
                     onerror="this.onerror=null; this.src='https://via.placeholder.com/30';">
                <%# Eval("TenDanhMuc") %>
            </asp:LinkButton>
        </div>
    </ItemTemplate>
</asp:Repeater>
                </div>

                <div class="price-filter mt-4">
                    <h5>LỌC THEO GIÁ</h5>
                    <div class="price-range">
                        <asp:TextBox ID="txtMinPrice" runat="server" Text="0" CssClass="form-control"  />
                        <span>-</span>
                        <asp:TextBox ID="txtMaxPrice" runat="server" Text="10000000" CssClass="form-control"  />
                    </div>
                   
                    <asp:Button ID="btnFilterPrice" runat="server" Text="LỌC" CssClass="btn btn-filter" OnClick="btnFilterPrice_Click" />
                </div>
            </div>

            <div class="col-lg-9 col-md-12">
                <div class="search-filter-container">
                    <div class="row align-items-center">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Nhập tên sản phẩm..." />
                                <div class="input-group-append">
                                    <asp:Button ID="btnSearch" runat="server" Text="🔍 Tìm" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnClear" runat="server" Text="✖ Xóa" CssClass="btn btn-danger" OnClick="btnClear_Click" />
                                    <asp:Button ID="btnRefresh" runat="server" Text="Làm mới" CssClass="btn btn-secondary" OnClick="btnRefresh_Click" />
                                </div>
                                
                            </div>
                        </div>
                        <div class="col-md-2 mb-2 mb-md-0">
                            <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" CssClass="form-control">
                                <asp:ListItem Value="" Selected="True">Sắp xếp mặc định</asp:ListItem>
                                <asp:ListItem Value="price_desc">Giá: Cao đến Thấp</asp:ListItem>
                                <asp:ListItem Value="price_asc">Giá: Thấp đến Cao</asp:ListItem>
                                <asp:ListItem Value="bestseller">Bán chạy nhất</asp:ListItem>
                                <asp:ListItem Value="newest">Mới nhất</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2 mb-3 mb-md-0">
                            <asp:DropDownList ID="ddlShow" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlShow_SelectedIndexChanged" CssClass="form-control">
                                <asp:ListItem Value="6" Selected="True">Hiển thị 6</asp:ListItem>
                                <asp:ListItem Value="12">Hiển thị 12</asp:ListItem>
                                <asp:ListItem Value="18">Hiển thị 18</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                       
                    </div>
                </div>

                <!-- Danh sách sản phẩm -->
                <div class="row grid">
                    <asp:Repeater ID="rProducts" runat="server" OnItemCommand="rProducts_ItemCommand">
                        <ItemTemplate>
                            <div class="col-lg-4 col-md-6 col-sm-12 pb-1">
                                <div class="card product-item border-0 mb-4">
                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                        <img class="img-fluid w-100" src="<%# KetNoi.getImageUrl(Eval("HinhAnhSanPham")) %>" alt="<%# Eval("TenSanPham") %>" />
                                        <%# Convert.ToBoolean(Eval("TrangThai")) ? "<span class='badge new'>NEW</span>" : "" %>
                                        <%# Convert.ToDecimal(Eval("Gia")) < Convert.ToDecimal(Eval("Gia")) * 1.2m ? "<span class='badge sale'>SALE</span>" : "" %>
                                    </div>
                                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                        <h6 class="text-truncate mb-3"><%# Eval("TenSanPham") %></h6>
                                        <p><%# Eval("MoTaNgan") %></p>
                                        <div class="price d-flex justify-content-center">
                                            <h6><%# Eval("Gia", "{0:N0} đ") %></h6>
                                            <h6 class="text-muted ml-2">
                                                <del><%# String.Format("{0:N0} đ", Convert.ToDecimal(Eval("Gia")) * 1.2m) %></del>
                                            </h6>
                                        </div>
                                        <a style="font-size: 14px;">Đã bán: <%# Eval("MonthlyOrders", "{0:N0}") %></a><br />
                                        <p>Ngày tạo: <%# Convert.ToDateTime(Eval("NgayTao")).ToString("dd/MM/yyyy") %></p>
                                    </div>
                                    <div class="card-footer d-flex justify-content-between bg-light border">
                                        <a href="ChiTiet.aspx?MaSanPham=<%# Eval("MaSanPham") %>" class="btn btn-sm text-dark p-0">
                                            <i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết
                                        </a>
                                        <asp:LinkButton ID="lbAddToCart" runat="server" CommandName="addToCart"
                                            CommandArgument='<%# Eval("MaSanPham") %>'
                                            CssClass="btn btn-sm text-dark p-0 d-flex justify-content-center align-items-center">
                                            <i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

               <!-- Phân trang -->
<div class="pagination-container">
    <div class="page-info">
        <asp:Label ID="lblPageInfo" runat="server" Text="1 of 3"></asp:Label>
    </div>
    <div class="pagination-buttons">
        <asp:Button ID="btnPrevPage" runat="server" Text="←" CssClass="btn-prev" OnClick="btnPrevPage_Click" />
        <asp:Button ID="btnNextPage" runat="server" Text="→" CssClass="btn-next" OnClick="btnNextPage_Click" />
    </div>
</div>

            </div>
        </div>
    </div>
</asp:Content>