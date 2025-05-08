<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="Web_PetHouse.NguoiDung.DangKy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .register-wrapper {
            width: 100%;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background: #edf1ff;
            padding-top: 50px;
        }

        .register-container {
            width: 100%;
            max-width: 600px;
            padding: 35px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .register-title {
            font-size: 26px;
            font-weight: bold;
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .form-col {
            width: calc(50% - 7.5px); 
        }

        @media (max-width: 768px) {
            .form-col {
                width: 100%; 
            }
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            transition: 0.3s;
            box-shadow: 0px 4px 8px rgba(0, 123, 255, 0.3);
            margin-top: 15px;
        }

        .auto-style8 {
            background-color: #fff;
            border: 1px solid #dee2e6;
            max-width: 100%;
        }

        .label-center {
            display: block;
            text-align: center;
            width: 100%;
        }

        .image-preview {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .image-preview img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 2px solid #007BFF;
            object-fit: cover;
        }
    </style>
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                var lblMsg = document.getElementById('<%= lblMsg.ClientID %>');
                if (lblMsg) {
                    lblMsg.style.display = "none";
                }
            }, seconds * 1000);
        };

        function XemTruocAnh(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%= imgUser.ClientID %>').prop('src', e.target.result)
                        .width(80)
                        .height(80);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

       
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="register-wrapper">
        <div class="register-container">
            <div class="register-title">
                <asp:Label ID="lblTitle" runat="server" Text="Đăng ký người dùng"></asp:Label>
            </div>
            <div class="form-row">
                <!-- Cột 1 -->
                <div class="form-col">
                    <div class="form-group">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nhập họ và tên"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Vui lòng nhập họ và tên" ControlToValidate="txtName" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Vui lòng nhập tên đăng nhập" ControlToValidate="txtUsername" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Nhập email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Vui lòng nhập email" ControlToValidate="txtEmail" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Vui lòng nhập số điện thoại" ControlToValidate="txtMobile" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <!-- Cột 2 -->
                <div class="form-col">
                    <div class="form-group">
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ" ToolTip="Địa chỉ"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Vui lòng nhập địa chỉ" ControlToValidate="txtAddress" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Nhập mã bưu điện" ToolTip="Mã bưu điện"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Vui lòng nhập mã bưu điện" ControlToValidate="txtPostCode" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Nhập mật khẩu" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Vui lòng nhập mật khẩu" ControlToValidate="txtPassword" CssClass="error-message text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="Chọn ảnh" onchange="XemTruocAnh(this);" />
                        <div class="image-preview">
                            <asp:Image ID="imgUser" runat="server" Visible="false" />
                            <asp:Label ID="lblImageNote" runat="server" Text="" Visible="false" />
                        </div>
                    </div>
                </div>
            </div>
            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="btn-register" OnClick="btnRegister_Click" OnClientClick="return true;" />
            <asp:Label ID="lblAlreadyUser" CssClass="label-center" runat="server" Text="Đã có tài khoản? <a href='DangNhap.aspx'>Đăng nhập tại đây</a>"></asp:Label>
            <asp:Label ID="lblMsg" runat="server" style="display:none;"></asp:Label>
        </div>
    </div>
</asp:Content>