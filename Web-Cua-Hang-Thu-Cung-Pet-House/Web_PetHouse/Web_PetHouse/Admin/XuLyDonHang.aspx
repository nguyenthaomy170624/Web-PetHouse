<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="XuLyDonHang.aspx.cs" Inherits="Web_PetHouse.Admin.XuLyDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .message-label {
            display: none;
        }
        .message-label.text-success {
            color: green;
        }
        .message-label.text-danger {
            color: red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server" CssClass="message-label"></asp:Label>
    </div>
    <div class="row">
        <div class="col-sm-5 col-md-5">
            <div class="card">
                <asp:Panel ID="pUpdateOrderStatus" runat="server">
                    <div class="card-body">
                        <h4 class="card-title">Cập nhật đơn hàng</h4>
                        <hr />
                        <div class="form-group">
                            <label>Trạng thái đơn hàng</label>
                            <div class="row">
                                <div class="col-md-12">
                           <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
    <asp:ListItem Value="0">Chọn trạng thái</asp:ListItem>
    <asp:ListItem Value="Đang xử lý">Đang xử lý</asp:ListItem>
    <asp:ListItem Value="Đã gửi">Đã gửi</asp:ListItem>
    <asp:ListItem Value="Đã giao">Đã giao</asp:ListItem>
</asp:DropDownList>
           <asp:RequiredFieldValidator ID="rfvDdlOrderStatus" runat="server" ForeColor="Red"
                                        ControlToValidate="ddlOrderStatus"
                                        ErrorMessage="Order status is required" SetFocusOnError="true" Display="Dynamic"
                                        InitialValue="0" />
                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                </div>
                            </div>
                            <div class="form-actiona pb-5">
                                <div class="text-left">
                                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-info" Text="Cập nhật" OnClick="btnUpdate_Click" />
                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-dark" Text="Hủy" OnClick="btnCancel_Click" />
                                </div>
                            </div>
                            <div>
                                <asp:Image ID="imagePreview" runat="server" CssClass="img-thumbnail" AlternateText="" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>

        <div class="col-sm-12 col-md-11">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Danh sách đơn hàng</h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rOrderStatus" runat="server" OnItemCommand="rOrderStatus_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Mã đơn hàng</th>
                                            <th>Ngày đặt hàng</th>
                                            <th>Trạng Thái</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Tổng tiền</th>
                                            <th>Phương thức thanh toán</th>
                                            <th class="datatable-nosort">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"><%# Eval("MaDonHang") %></td>
                                    <td><%# Eval("NgayDatHang") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server"
                                            Text='<%# Eval("TrangThai") %>'
                                            CssClass='<%# Eval("TrangThai").ToString()=="Đã giao" ? "badge badge-success" :"badge badge-warning" %>'>
                                        </asp:Label>
                                    </td>
                                    <td><%# Eval("TenSanPham") %></td>
                                    <td><%# Eval("TotalPrice") %></td>
                                    <td><%# Eval("HinhThucThanhToan") %></td>
                                    <td>
                                        <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                            CommandArgument='<%# Eval("MaDonHang") %>' CommandName="edit" CausesValidation="false">
                                            <i class="fas fa-edit"></i>
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
    </div>
</asp:Content>