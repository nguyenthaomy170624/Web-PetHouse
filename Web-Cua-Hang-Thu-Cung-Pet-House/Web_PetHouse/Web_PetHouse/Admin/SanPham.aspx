<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="Web_PetHouse.Admin.SanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById('<%= lblMsg.ClientID %>').style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%= imagePreview.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Sản Phẩm</h4>
                    <hr />
                    <div class="form-group">
                        <label>Tên Sản Phẩm</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Nhập tên sản phẩm"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductName"
                            ErrorMessage="Vui lòng nhập tên sản phẩm!"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Mô Tả Ngắn</label>
                        <asp:TextBox ID="txtShortDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Nhập mô tả ngắn"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Mô Tả Chi Tiết</label>
                        <asp:TextBox ID="txtDetailDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Nhập mô tả chi tiết"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Giá</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Nhập giá sản phẩm" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPrice"
                            ErrorMessage="Vui lòng nhập giá sản phẩm!"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvPrice" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPrice"
                            MinimumValue="0" MaximumValue="999999999" Type="Double"
                            ErrorMessage="Giá phải lớn hơn hoặc bằng 0!"></asp:RangeValidator>
                    </div>
                    <div class="form-group">
                        <label>Số Lượng</label>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Nhập số lượng" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtQuantity"
                            ErrorMessage="Vui lòng nhập số lượng!"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvQuantity" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtQuantity"
                            MinimumValue="0" MaximumValue="999999" Type="Integer"
                            ErrorMessage="Số lượng phải lớn hơn hoặc bằng 0!"></asp:RangeValidator>
                    </div>
                    <div class="form-group">
                        <label>Nhà Sản Xuất</label>
                        <asp:TextBox ID="txtManufacturer" runat="server" CssClass="form-control" placeholder="Nhập nhà sản xuất"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Danh Mục</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" Font-Size="Small"
                            Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory"
                            InitialValue="0" ErrorMessage="Vui lòng chọn danh mục!"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Danh Mục Con</label>
                        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Ảnh Sản Phẩm</label>
                        <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
                        <asp:HiddenField ID="hfProductId" runat="server" Value="0" />
                    </div>
                    <div class="form-group">
                        <asp:CheckBox ID="cbIsActive" runat="server" Text="  Trạng Thái" />
                    </div>
                    <div class="form-actions pb-5">
                        <asp:Button ID="btnAddOrUpdate" runat="server" CssClass="btn btn-info" Text="Thêm" OnClick="btnAddOrUpdate_Click"/>
                        <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" OnClick="btnClear_Click" />
                    </div>
                    <div>
                        <asp:Image ID="imagePreview" runat="server" CssClass="img-thumbnail" AlternateText="" />
                    </div>
                </div>
            </div>
        </div>
       <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Danh Sách Sản Phẩm</h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Tên</th>
                                            <th>Hình Ảnh</th>
                                            <th>Giá</th>
                                            <th>Số Lượng</th>
                                            <th>Danh Mục</th>
                                            <th>Danh Mục Con</th>
                                            <th>Trạng Thái</th>
                                            <th>Ngày Tạo</th>
                                            <th class="datatable-nosort">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"><%# Eval("TenSanPham") %></td>
                                    <td>
                                        <img width="48" src="<%# Web_PetHouse.KetNoi.getImageUrl(Eval("HinhAnhSanPham")) %>" alt="image" />
                                    </td>
                                    <td><%# Eval("Gia", "{0:N0}") %></td>
                                    <td><%# Eval("SoLuong") %></td>
                                    <td><%# Eval("TenDanhMuc") %></td>
                                    <td><%# Eval("TenDanhMucCon") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server"
                                            Text='<%# (bool)Eval("TrangThai") ? "Kích hoạt" : "Chưa kích hoạt" %>'
                                            CssClass='<%# (bool)Eval("TrangThai") ? "badge badge-success" : "badge badge-danger" %>'>
                                        </asp:Label>
                                    </td>
                                    <td><%# Eval("NgayTao") %></td>
                                    <td>
                                        <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                            CommandArgument='<%# Eval("MaSanPham") %>' CommandName="edit" CausesValidation="false">
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                            CommandArgument='<%# Eval("MaSanPham") %>' CommandName="delete" CausesValidation="false"
                                            OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
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
    </div>
</asp:Content>