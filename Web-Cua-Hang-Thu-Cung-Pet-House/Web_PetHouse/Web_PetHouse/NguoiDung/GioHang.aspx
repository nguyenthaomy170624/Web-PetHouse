<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="Web_PetHouse.NguoiDung.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

    <style>
        .container {
            width: 90%;
            max-width: 1300px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .cart-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-primary {
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .cart-table th, .cart-table td {
            text-align: left;
            padding: 10px 15px;
            border-bottom: 1px solid #e0e0e0;
            font-family: 'Arial', sans-serif;
            font-size: 14px;
            color: #333;
        }

        .cart-table img {
            width: 50px;
            border-radius: 5px;
        }

        .btn-primary, .btn-danger {
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #007bff;
            color: #fff;
        }

        .btn-danger {
            background: #dc3545;
            color: #fff;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-danger:hover {
            background: #c82333;
        }
    </style>

    <script>
        window.onload = function () {
            particlesJS("particles-js", {
                particles: {
                    number: { value: 50 },
                    size: { value: 3 }
                }
            });
        };

        function showSuccessAlert(message) {
            Swal.fire({
                title: 'Thành công!',
                text: message,
                icon: 'success',
                customClass: {
                    popup: 'custom-swal-popup',
                    title: 'custom-swal-title',
                    htmlContainer: 'custom-swal-text',
                    confirmButton: 'custom-swal-button'
                }
            }).then(() => {
                confetti({
                    particleCount: 100,
                    spread: 70,
                    origin: { y: 0.6 }
                });
                document.getElementById('successSound').play();
            });
        }

        function showErrorAlert(message) {
            Swal.fire({
                title: 'Lỗi!',
                text: message,
                icon: 'error',
                customClass: {
                    popup: 'custom-swal-popup',
                    title: 'custom-swal-title',
                    htmlContainer: 'custom-swal-text',
                    confirmButton: 'custom-swal-button'
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand1" OnItemDataBound="rCartItem_ItemDataBound1">
        <HeaderTemplate>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Sản Phẩm</th>
                        <th>Hình Ảnh</th>
                        <th>Giá</th>
                        <th>Số Lượng</th>
                        <th>Tổng Tiền</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><asp:Label ID="lblName" runat="server" Text='<%# Eval("TenSanPham") %>'></asp:Label></td>
                <td><img src='<%# Web_PetHouse.KetNoi.getImageUrl(Eval("HinhAnhSanPham")) %>' alt="Ảnh sản phẩm" /></td>
                <td><asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Gia") %>'></asp:Label> VNĐ</td>
                <td>
                    <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" CssClass="form-control" Text='<%# Eval("SoLuong") %>'></asp:TextBox>
                    <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("MaSanPham") %>' />
                    <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("PrdQty") %>' />
                </td>
                <td><asp:Label ID="lblTotalPrice" runat="server"></asp:Label></td>
                <td>
                    <asp:LinkButton ID="lbDelete" runat="server" CommandName="remove" CommandArgument='<%# Eval("MaSanPham") %>' CssClass="btn-danger">
                        <i class="fa fa-trash"></i> Xóa
                    </asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            <tr>
                <td colspan="4"></td>
                <td><b>Tổng Tiền:</b> <% Response.Write(Session["grandTotalPrice"] != null ? Session["grandTotalPrice"] : "0 VNĐ"); %></td>
                <td></td>
            </tr>
            </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>

    <div class="cart-actions">
        <a href="CuaHang.aspx" class="btn-primary">
            <i class="fa fa-arrow-left"></i> Tiếp Tục Mua Hàng
        </a>
        <asp:LinkButton ID="lbUpdateCart" runat="server" OnClick="lbUpdateCart_Click" CssClass="btn-primary">
            <i class="fa fa-sync"></i> Cập Nhật Giỏ Hàng
        </asp:LinkButton>
        <asp:LinkButton ID="lbCheckout" runat="server" OnClick="lbCheckout_Click" CssClass="btn-primary">
            <i class="fa fa-credit-card"></i> Thanh Toán
        </asp:LinkButton>
    </div>
</asp:Content>