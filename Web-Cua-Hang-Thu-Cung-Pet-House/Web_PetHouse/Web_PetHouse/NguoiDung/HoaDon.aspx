<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="HoaDon.aspx.cs" Inherits="Web_PetHouse.NguoiDung.HoaDon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .invoice-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
        }
        .table th {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
            vertical-align: bottom;
            padding: 12px;
            text-align: left;
        }
        .table td {
            padding: 12px;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }
        .btn-download {
            background-color: #1da1f2;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            transition: background-color 0.3s;
        }
        .btn-download:hover {
            background-color: #218838;
            color: white;
        }
        .heading_container h2 {
            color: #343a40;
            margin-bottom: 30px;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">                
        <h2>HÓA ĐƠN CỦA BẠN</h2>
        
                <div class="col-md-20 invoice-container">
                    <div class="table-responsive">
                        <asp:Repeater ID="rOrderItem" runat="server">
                            <HeaderTemplate>
                                <table class="table" id="tblInvoice">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã đặt hàng</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Tổng tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SrNo") %></td>
                                    <td><%# Eval("MaDonHang") %></td>
                                    <td><%# Eval("TenSanPham") %></td>
                                    <td><%# string.IsNullOrEmpty(Eval("Gia").ToString()) ? "" : String.Format("{0:N0} VND", Eval("Gia")) %></td>
                                    <td><%# Eval("SoLuong") %></td>
                                    <td><%# String.Format("{0:N0} VND", Eval("TotalPrice")) %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div class="text-center">
                            <asp:LinkButton ID="lbDownloadInvoice" runat="server" CssClass="btn-download" OnClick="lbDownloadInvoice_Click">
                                <i class="fa fa-file-pdf mr-2"></i> Tải Hóa Đơn
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
    </section>
</asp:Content>