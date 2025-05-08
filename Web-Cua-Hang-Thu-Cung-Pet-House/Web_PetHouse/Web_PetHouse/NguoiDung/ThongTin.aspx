<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="ThongTin.aspx.cs" Inherits="Web_PetHouse.NguoiDung.ThongTin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <style>
.card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    background: white;
    max-width: 1100px;
    margin: 20px auto;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
}


.card-body {
    width: 100%;
    text-align: left; 
    padding: 10px;

}

.card-body.bg-blue {
    background: #007BFF;
    color: white;
    border-radius: 8px;
    padding: 10px;
}

.image-container {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.image-container img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    border: 4px solid #007BFF;
    object-fit: cover;
    transition: transform 0.3s ease-in-out;
}

.image-container img:hover {
    transform: scale(1.1);
    border-color: #0056b3;
}

.middle {
    margin-top: 10px;
}

.middle a {
    background: #007BFF;
    color: white;
    padding: 10px 15px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
    transition: background 0.3s ease-in-out;
}

.middle a:hover {
    background: #0056b3;
}

.userData h2 {
    color: #333;
    margin-bottom: 5px;
}

.userData h6 {
    color: #555;
    font-weight: normal;
    margin-bottom: 10px;
}

.nav-tabs {
    justify-content: center;
}


.nav-tabs .nav-item .nav-link {
    color: #17a2b8; 
    font-weight: bold;
    transition: background 0.3s ease-in-out, color 0.3s ease-in-out;
}


.nav-tabs .nav-item .nav-link.active {
    background: #007bff;
    color: white !important;
}
element.style {
    font-weight: bold;
    color: #007bff!important;
}

table {
    width: 1000px;
    border-collapse: collapse;
    margin-top: 10px;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

table th {
    background: #007BFF;
    color: white;
}

.badge-success {
    background: green;
    color: white;
}

.badge-warning {
    background: orange;
    color: white;
}
label {
    font-weight: bold;
    color: #007bff !important;
}
</style>


    <%
        string imageUrl = Session["HinhAnh"]?.ToString();
    %>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title mb-4">
                                <div class="d-flex justify-content-start">
                                    <div class="image-container">
                                        <img 
                                            src="<%= Web_PetHouse.KetNoi.getImageUrl1(imageUrl) %>" 
                                            id="imgProfile" 
                                            style="width:150px; height:150px;" 
                                            class="img-thumbnail" 
                                            onerror="this.src='../Images/No_image.png';" />
                                        <div class="middle pt-2">
                                            <a href="DangKy.aspx?id=<%= Session["MaNguoiDung"] %>" 
                                               class="btn btn-warning">
                                                <i class="fa fa-pencil"></i> Chỉnh sửa thông tin
                                            </a>
                                        </div>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block"><% Response.Write(Session["HoTen"]); %></h2>
                                        <h6 class="d-block">
                                            <asp:Label ID="lblUsername" runat="server" ToolTip="Unique Username">
                                                <% Response.Write(Session["TenDangNhap"]); %>
                                            </asp:Label>
                                        </h6>
                                        <h6 class="d-block">
                                            <asp:Label ID="lblEmail" runat="server" ToolTip="User Email">
                                                <% Response.Write(Session["Email"]); %>
                                            </asp:Label>
                                        </h6>
                                        <h6 class="d-block">
                                            <asp:Label ID="lblCreatedDate" runat="server" ToolTip="Account Created On">
                                                <% Response.Write(Session["NgayTao"]); %>
                                            </asp:Label>
                                        </h6>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active text-info" id="basicInfo-tab" data-toggle="tab" href="#basicInfo" role="tab" aria-controls="basicInfo" aria-selected="true">
                                                <i class="fa fa-id-badge mr-2"></i>Thông tin cơ bản
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-info" id="connectedServices-tab" data-toggle="tab" href="#connectedServices" role="tab" aria-controls="connectedServices" aria-selected="false">
                                                <i class="fa fa-clock-o mr-2"></i>Lịch sử mua hàng
                                            </a>
                                        </li>
                                    </ul>

                                    <div class="tab-content ml-1" id="myTabContent">
                                        <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                            <asp:Repeater ID="rUserProfile" runat="server">
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Họ và tên</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("HoTen") %></div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Username</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("TenDangNhap") %></div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Số điện thoại</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("SoDienThoai") %></div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Email</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("Email") %></div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Post Code</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("MaBuuDien") %></div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold; color: #ff6f61;">Địa chỉ</label>
                                                        </div>
                                                        <div class="col-md-8 col-6"><%# Eval("DiaChi") %></div>
                                                    </div>
                                                    <hr />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>

                                        <div class="tab-pane fade" id="connectedServices" role="tabpanel" aria-labelledby="connectedServices-tab">
                                            
                                            <asp:Repeater ID="rPurchaseHistory" runat="server" OnItemDataBound="rPurchaseHistory_ItemDataBound">
                                                <ItemTemplate>
                                                    
                                                    
                                                        <div class="row pt-1 pb-1">
                                                            <div class="col-12">
                                                                <span class="badge badge-pill badge-dark text-white"><%# Eval("SrNo") %></span>
                                                                Phương thức: <%# Eval("HinhThucThanhToan").ToString() == "cod" ? "Thanh toán khi nhận hàng" : Eval("HinhThucThanhToan").ToString().ToUpper() %>
          
                                                                <%# string.IsNullOrEmpty(Eval("SoThe").ToString()) ? "" : "Số thẻ: " + Eval("SoThe") %>
                                                          
                                                                <a href="HoaDon.aspx?id=<%# Eval("MaThanhToan") %>" class="btn btn-info btn-sm">
                                                                    <i class="fa fa-download mr-2"></i>Hoá đơn
                                                                </a>
                                                            </div>
                                                        </div>
                                                    <div class="container ml-1">

                                                        <asp:HiddenField ID="hdnPaymentId" runat="server" Value='<%# Eval("MaThanhToan") %>' />

                                                        <asp:Repeater ID="rOrders" runat="server">
                                                            <HeaderTemplate>
                                                                <table>
                                                                    <thead>
                                                                        <tr>
                                                                         <th>Mã đơn hàng</th>
                                                                            <th>Tên sản phẩm</th>
                                                                            <th>Giá</th>
                                                                            <th>Số lượng</th>
                                                                            <th>Tổng tiền</th>
                                                                            <th>Trạng thái</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr style="font-weight: bold;color: #007bff;">                                                                    
                                                                    <td><asp:Label ID="lblOrderNo" runat="server" Text='<%# Eval("MaDonHang") %>'></asp:Label></td>
                                                                    <td><asp:Label ID="lblName" runat="server" Text='<%# Eval("TenSanPham") %>'></asp:Label></td>
                                                                    <td><asp:Label ID="lblPrice" runat="server" Text='<%# string.IsNullOrEmpty(Eval("Gia").ToString()) ? "" : Eval("Gia") + " VND" %>'></asp:Label></td>
                                                                    <td><asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("SoLuong") %>'></asp:Label></td>
                                                                    <td><asp:Label ID="lblTotalPrice" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label> VND</td>
                                                                    <td><asp:Label ID="lblStatus" runat="server" Text='<%# Eval("TrangThai") %>' CssClass='<%# Eval("TrangThai").ToString() == "Đã giao hàng" ? "badge badge-success" : "badge badge-warning" %>'></asp:Label></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                    </tbody>
                                                                </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
     
</asp:Content>
