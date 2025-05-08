<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="KhachHang.aspx.cs" Inherits="Web_PetHouse.Admin.KhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById('<%= lblMsg.ClientID %>').style.display = "none";
         }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

    <div class="col-12 mobile-inputs">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Danh sách người dùng</h4>
                <hr />
                <div class="table-responsive">
                    <asp:Repeater ID="rUsers" runat="server" OnItemCommand="rUsers_ItemCommand">
                        <HeaderTemplate>
                            <table class="table data-table-export table-hover nowrap">
                                <thead>
                                    <tr>
                                        <th class="table-plus">STT</th>
                                        <th>Họ và tên</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Email</th>
                                        <th>Ngày tạo</th>
                                        <th class="datatable-nosort">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="table-plus"><%# Eval("STT") %></td>
                                <td>
                                    <%# Eval("HoTen") %>
                                </td>
                                <td>
                                    <%# Eval("TenDangNhap") %>
                                </td>
                                <td>
                                    <%# Eval("Email") %>
                                </td>
                                <td><%# Eval("NgayTao") %></td>
                                <td>

                                    <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                        CommandArgument='<%# Eval("MaNguoiDung") %>' CommandName="delete" CausesValidation="false"
                                        OnClientClick="return confirm('Bạn có muốn xóa người dùng này không?');">
                                <i class="far fa-trash-alt"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                    </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
