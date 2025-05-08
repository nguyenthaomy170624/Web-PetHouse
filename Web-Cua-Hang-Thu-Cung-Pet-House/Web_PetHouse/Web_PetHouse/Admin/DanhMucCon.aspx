<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DanhMucCon.aspx.cs" Inherits="Web_PetHouse.Admin.DanhMucCon" %>
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
    <div class="row">
    <div class="col-sm-12 col-md-4">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Danh Mục Con</h4>
                <hr />
                  <div class="form-group">
                  <label>Tên Danh Mục Con</label>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="form-group">
                              <asp:TextBox ID="txtSubCategoryName" runat="server" CssClass="form-control" placeholder="Nhập tên danh mục con"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvSubCategoryName" runat="server" ForeColor="Red" Font-Size="Small"
                                  Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtSubCategoryName"
                                  ErrorMessage="Vui lòng nhập tên danh mục con!"></asp:RequiredFieldValidator>
                          </div>
                      </div>
                  </div>
                  <label>Danh Mục</label>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="form-group">
                              <asp:DropDownList ID="ddlCategory" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                              <asp:ListItem Value="0">Chọn danh mục</asp:ListItem>
                              </asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvSubCategory" runat="server" ForeColor="Red" Font-Size="Small"
                                Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory"
                                ErrorMessage="Vui lòng chọn danh mục!" InitialValue="0"></asp:RequiredFieldValidator>

                                <asp:HiddenField ID="hfSubCategoryId" runat="server" Value="0" />

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
                      
              </div>
            </div>
        </div>
    </div>
<div class="col-sm-12 col-md-8">
    <div class="card">
    <div class="card-body">
        <h4 class="card-title">Danh sách danh mục con</h4>
        <hr />
        <div class="table-responsive">
            <asp:Repeater ID="rSubCategory" runat="server" OnItemCommand="rSubCategory_ItemCommand">
                <HeaderTemplate>
                    <table class="table data-table-export table-hover nowrap">
                        <thead>
                            <tr>
                                <th class="table-plus">Tên danh mục con</th>
                                <th>Danh Mục</th>
                                <th>Trạng Thái</th>
                                <th>Ngày tạo</th>
                                <th class="datatable-nosort">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="table-plus"><%# Eval("TenDanhMucCon") %></td>
                        <td>
                            <%# Eval("TenDanhMuc") %>
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
                                  CommandArgument='<%# Eval("MaDanhMucCon") %>' CommandName="edit" CausesValidation="false" >
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                            CommandArgument='<%# Eval("MaDanhMucCon") %>' CommandName="delete" CausesValidation="false">
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
