<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DanhMuc.aspx.cs" Inherits="Web_PetHouse.Admin.DanhMuc" %>
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
                <h4 class="card-title">Danh Mục</h4>
                <hr />
                  <div class="form-group">
                  <label>Tên Danh Mục</label>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="form-group">
                              <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Nhập tên danh mục"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ForeColor="Red" Font-Size="Small"
                                  Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtCategoryName"
                                  ErrorMessage="Vui lòng nhập tên danh mục!"></asp:RequiredFieldValidator>
                          </div>
                      </div>
                  </div>
                  <label>Ảnh Danh Mục</label>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="form-group">
                              <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="form-control"
                                  onchange="ImagePreview(this);" />
                                <asp:HiddenField ID="hfCategoryId" runat="server" Value="0" />

                          </div>
                      </div>
                  </div>
                  <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Trạng Thái" />
                            </div>
                        </div>
                    </div>

                      <div class="form-actiona pb-5">
                          <div class="text-left">
                               <asp:Button ID="btnAddOrUpdate" runat="server" CssClass="btn btn-info" Text="Thêm" OnClick="btnAddOrUpdate_Click" />
                               <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Làm mới" OnClick="btnClear_Click" />

                          </div>
                      </div>
                      <div>
                          <asp:Image ID="imagePreview" runat="server" CssClass="img-thumbnail" AlternateText="" />
                      </div>
              </div>
            </div>
        </div>
    </div>
<div class="col-sm-12 col-md-8">
    <div class="card">
    <div class="card-body">
        <h4 class="card-title">Danh sách danh mục</h4>
        <hr />
        <div class="table-responsive">
            <asp:Repeater ID="rCategory" runat="server" OnItemCommand="rCategory_ItemCommand">
                <HeaderTemplate>
                    <table class="table data-table-export table-hover nowrap">
                        <thead>
                            <tr>
                                <th class="table-plus">Tên</th>
                                <th>Hình Ảnh</th>
                                <th>Trạng Thái</th>
                                <th>Ngày tạo</th>
                                <th class="datatable-nosort">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="table-plus"><%# Eval("TenDanhMuc") %></td>
                        <td>
                            <img width="48" src="<%# Web_PetHouse.KetNoi.getImageUrl(Eval("HinhAnhDanhMuc")) %>" alt="image" />
                        </td>
                        <td>
                            <asp:Label ID="lblIsActive" runat="server"
                                Text='<%# (bool)Eval("TrangThai") == true ? "Kích hoạt" : "Chưa kích hoạt" %>'
                                CssClass='<%# (bool)Eval("TrangThai") == true ? "badge badge-success" : "badge badge-danger" %>'>
                            </asp:Label>
                        </td>
                        <td><%# Eval("NgayTao") %></td>
                        <td>
                            <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                  CommandArgument='<%# Eval("MaDanhMuc") %>' CommandName="edit" CausesValidation="false" >
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                            CommandArgument='<%# Eval("MaDanhMuc") %>' CommandName="delete" CausesValidation="false">
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
